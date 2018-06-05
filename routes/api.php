<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
*/

Route::group(['prefix' => 'auth'], function ($router) {

    Route::post('login', 'AuthController@login');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::post('me', 'AuthController@me');
	Route::post('register', 'AuthController@register');
	Route::post('changepassword/{user}', 'AuthController@ChangePassword');
	Route::post('changename/{user}', 'AuthController@ChangeName');


});

Route::group(['prefix' => 'quiz'], function ($router) {

    Route::get('all', 'QuizController@index');
    Route::get('scores', 'QuizController@QuizzersScores');
    Route::get('scores/get', 'QuizController@Scores');
    Route::get('get/{quiz}', 'QuizController@getQuizQuestions');
    Route::post('storeresults/{quiz}', 'QuizController@storeResult');
    Route::post('storequizquestion', 'QuizController@StoreQuizQuestions');
    Route::get('profile/{user}', 'QuizController@GetUserDetails');
    Route::get('delete/{quiz}', 'QuizController@Delete');



});