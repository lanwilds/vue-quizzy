<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Quiz extends Model
{
	protected $fillable =[
		'title',
		'user_id',
        'time_period'
	];
    public function toArray()
    {
    	return [
            'id' => $this->id,
    		'title' => $this->title,
    	    'created_at' => $this->created_at->diffForHumans(),
            'user_name' => $this->users()->first()->name,
            'questCount' => $this->questions()->count()
    	];
    }
    public function users()
    {
    	return $this->belongsTo('App\User','user_id');
    }
    public function questions()
    {
    	return $this->HasMany('App\Question');
    }
    public function scores()
    {
        return $this->HasMany('App\Score');
    }
}
