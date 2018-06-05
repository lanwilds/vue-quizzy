<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Quiz;
use App\Question;
use App\Choice;
use App\Quizlog;
use App\Score;
use App\User;
use Validator;

class QuizController extends Controller
{
	public function __construct()
	{
	    $this->middleware('jwt.auth',['except' => ['index']]);
	}
    public function index()
    {
    	return response()->json([
    		'quizzes' => Quiz::has('questions')->with('users')->paginate(9)->toArray()
    	]);
    }
    public function Delete(Quiz $quiz)
    {
        if(auth()->user()->role != 'admin')
        {
            return response()->json([
                'status' => false
            ],403);
        }
        return response()->json([
            'status' => $quiz->delete()
        ],200);
    }
    public function QuizzersScores()
    {

    	return response()->json([
    		'quizzes' => Quiz::has('scores')->paginate(9)->toArray()
    	]);
    }
    public function getQuizQuestions(Quiz $quiz)
    {
    	$questions = Question::inRandomOrder()->with('choices')->where('quiz_id',$quiz->id)->get(); 

    	return response()->json([
    		'questions' => $questions,
            'timePeriod' => $quiz->time_period
    	]);
    }
    public function storeResult(Quiz $quiz,Request $request)
    {
    	$request->validate([
    		'questions' => 'required|array',
    		'answers' => 'required|array',
            'time' => 'required'
    	]);

    	$attempt = Score::where('user_id',auth()->user()->id)->where('quiz_id',$quiz->id);
    	if($attempt->count())
    	{
    		$attempt = $attempt->orderBy('attempt','DESC')->first()->attempt;
    		$attempt += 1;
    	}
    	else
    	{
    		$attempt = 1;
    	}
    	$questions = $request->questions;
    	$answers = $request->answers;
    	$score = 0;

    	if(count($questions) == count($answers))
    	{
    		for($i=0;$i<count($answers);$i++)
    		{
    			$choice = Choice::find($answers[$i]);

    			if($choice)
    			{
    				if($choice->right_choice == 1)
    				{
    					$score+=1;
    				}
    			}
    		}
    		$scores = Score::create([
    			'score' => $score,
    			'quiz_id' => $quiz->id,
    			'attempt' => $attempt,
    			'user_id' => auth()->user()->id,
                'time' => $request->time
    		]);
    		return response()->json([
    			'score' => $scores->score,
    			'attempts' => $scores->attempt,
    			'totalQuestions' => $quiz->questions()->count()
    		]);
    	}
    	return response()->json([
    		'error' => true
    	],403);

    }
    public function StoreQuizQuestions(Request $request)
    {
    	$validate = Validator::make($request->all(),[
    		'questions.*.title' => 'required|max:100',
    		'questions.*.choices' => 'required|array|min:3',
    		'questions.*.rightChoice' => 'required|numeric',
            'quiz' => 'required|array|min:2',
            'quiz.title' => 'required|min:5',
    		'quiz.time' => 'required|numeric|min:1|max:60',
    	]);
    	if($validate->fails())
    	{
    		return response()->json([
    			'quiz' => null,
    			'errors' => $validate->errors()
    		]);
    	}
    	//create quiz
    	
    	$quiz = Quiz::create([
            'title' => $request->quiz["title"],
    		'time_period' => $request->quiz["time"],
    		'user_id' => auth()->user()->id
    	]);
    	$questions = $request->questions;
    	//create question
    	foreach ($questions as $q) 
    	{
    		$quest = Question::create([
    			'question' => $q['title'],
    			'status' => 1,
    			'quiz_id' => $quiz->id,
    			'user_id' => auth()->user()->id
    		]);	
			
			//add choices to question
			$index = 0;
			foreach ($q['choices'] as $c) 
			{
				if($index == $q['rightChoice'])
				{
					$rightChoice = 1;
				}
				else
				{
					$rightChoice = 0;
				}
				Choice::create([
					'question_id' => $quest->id,
					'right_choice' => $rightChoice,
					'choice' => $c
				]);
				$index++;
			}

    	}
    	
    	return response()->json([
    		'quiz' => $quiz->title
    	]);
    }
    public function GetUserDetails(Request $request,User $user)
    {
    	if(auth()->user()->id != $user->id)
    	{
    		return response()->json([
    			'status' => false,
    		],403);
    	}
    	return response()->json([
    		'user' => $user,
    		'quizCreated' => $user->quizzes()->count(),
    		'quizPlayed' => $user->scores()->count()
    	]);
    }
    public function Scores()
    {
    	$quizzes = Quiz::has('scores')->orderBy('created_at','DESC')->paginate(5);
    	$scoreboard = [];
    	foreach ($quizzes as $q) 
    	{
    		//$users = [];
    		$scores = Score::with('users')->where('quiz_id',$q->id)->orderBy('score','DESC')->orderBy('attempt','ASC')->limit(3)->get();
    		
    		
    		array_push($scoreboard,['quizTitle' => $q->title,'scores' => $scores]);
    	}

    	return response()->json([
    		'scores' => $scoreboard,
            'last_page' => $quizzes->lastPage(),
            'current_page' => $quizzes->currentPage(),
    	]);
    }
}
