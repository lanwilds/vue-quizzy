<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Score extends Model
{
	protected $fillable = [
		'quiz_id',
		'user_id',
		'attempt',
		'score',
		'time'
	];
	public function quizzes()
	{
		return $this->belongsTo('App\Quiz');
	}
	public function users()
	{
		return $this->belongsTo('App\User','user_id');
	}
}
