<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Quizlog extends Model
{
    protected $fillable = [
    	'question_id',
    	'choice_id',
    	'user_id',
    	'is_correct',
    	'attempt',
    ];
}
