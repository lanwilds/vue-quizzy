<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
	protected $fillable=[
		'question',
		'status',
		'quiz_id',
		'user_id'
	];
    public function quizzes()
    {
    	return $this->belongsTo('App\Quiz');
    }
    public function choices()
    {
    	return $this->HasMany('App\Choice');
    }
}
