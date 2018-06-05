<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Validator;
use App\User;

class AuthController extends Controller
{
    /**
        * Create a new AuthController instance.
        *
        * @return void
        */
       public function __construct()
       {
           $this->middleware('auth:api', ['except' => ['login','register']]);
       }

       /**
        * Get a JWT via given credentials.
        *
        * @return \Illuminate\Http\JsonResponse
        */
       public function login()
       {
           $credentials = request(['email', 'password']);

           if (! $token = auth('api')->attempt($credentials)) {
               return response()->json(['error' => 'Unauthorized'], 401);
           }

           return $this->respondWithToken($token);
       }

       /**
        * Get the authenticated User.
        *
        * @return \Illuminate\Http\JsonResponse
        */
       public function me()
       {
           return response()->json(auth('api')->user());
       }

       /**
        * Log the user out (Invalidate the token).
        *
        * @return \Illuminate\Http\JsonResponse
        */
       public function logout()
       {
           auth('api')->logout();

           return response()->json(['message' => 'Successfully logged out']);
       }

       /**
        * Refresh a token.
        *
        * @return \Illuminate\Http\JsonResponse
        */
       public function refresh()
       {
           return $this->respondWithToken(auth('api')->refresh());
       }

       /**
        * Get the token array structure.
        *
        * @param  string $token
        *
        * @return \Illuminate\Http\JsonResponse
        */
       protected function respondWithToken($token)
       {
           return response()->json([
               'access_token' => $token,
               'user' => $this->guard()->user(),
               'token_type' => 'bearer',
               'expires_in' => auth('api')->factory()->getTTL() * 60
           ]);
       }
       public function guard()
       {
       		return Auth::Guard('api');
       }
       public function register(Request $request)
       {
          $validate = Validator::make($request->all(),[
            'name' => 'required|min:3',
            'email' => 'required|unique:users',
            'password' => 'required|min:6'
          ]);

          if($validate->fails())
          {
            return response()->json([
              'msg' => 'Email is already taken'
            ],403);
          }

          User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'role' => 'normal'
          ]);

          return response()->json([
            'msg' => 'Registration Successful, Please proceed for login'
          ]);
       }
       public function ChangeName(Request $request,User $user)
       {
          if(auth()->user()->id != $user->id)
          {
            return response()->json([
             'status' => false
            ]);
          }
          $request->validate([
            'name' => 'required|min:3'
          ]);
         $user->name = $request->name;
         $user->save();
         return response()->json([
          'status' => true,
          'name' => $user->name 
         ]);
       }
       public function ChangePassword(Request $request,User $user)
       {
        if(auth()->user()->id != $user->id)
        {
          return response()->json([
           'status' => false
          ]);
        }
         $request->validate([
           'password' => 'required|min:3'
         ]);
        $user->password = bcrypt($request->password);
        $user->save();
        return response()->json([
         'status' => true
        ]);
       }
}
