<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Choice extends Model
{
	protected $fillable=[
		'choice',
		'question_id',
		'right_choice'
	];
    public function questions()
    {
    	return $this->belongsTo('App\Question');
    }
}
