import { getLocalUser } from './helpers/auth';
const user = getLocalUser();
export default{
	state:{
		currentUser:user,
		isLoggedIn:!!user,
		loading:false,
		authErr:null,
		message:'',
		quizzes:[],
		pages:0,
		currentPage:0,
		questions:[],
		currentQuestion:[],
		quiz:null,
		result:[],
		profileDetails:[],
		scoreboard:[],
		timePeriod:0,
		currentTime:null,
		timerObj:null
	},
	getters:{
		isLoading(state){
			return state.loading;
		},
		isLoggedIn(state){
			return state.isLoggedIn;
		},
		currentUser(state){
			return state.currentUser;
		},
		authError(state){
			return state.authErr;
		},
		getMessage(state){
			return state.message;
		},
		getQuizzes(state){
			return state.quizzes;
		},
		getQuestions(state){
			return state.questions;
		},
		getCurrQuestions(state){
			return state.currentQuestion;
		},
		getScores(state){
			return state.result;
		},
		getProfileDetails(state){
			return state.profileDetails;
		},
		getProfileLink(state){
			return '/profile/'+state.currentUser.id;
		},
		getQuizzyScores(state){
			return state.scoreboard;
		},
		getTimer(state){
			return state.timePeriod;
		},
		getCurrentTime(state){
			return state.currentTime;
		}
	},
	mutations:{
		login(state){
			state.loading = true;
			state.authErr = null;
		},
		loginSuccess(state,payload){
			state.authErr = null;
			state.isLoggedIn = true;
			state.loading = false;
			state.message = "Howdy! You have been Logged in...";
			state.currentUser = Object.assign({},payload.user,{token:payload.access_token});

			localStorage.setItem("user",JSON.stringify(state.currentUser));
		},
		loginFailed(state,payload){
			state.message="Invalid Credentials"
			state.loading = false;
			state.authErr = payload.error;
		},

		register(state){
			state.loading = true;
			state.authErr = null;
		},
		registerSuccess(state,payload){
			state.authErr = null;
			state.loading = false;
			state.message = "Register Success, Please proceed to login";
		},
		registerFailed(state,payload){
			state.loading = false;
			state.authErr = payload.error;
			state.message = payload.error.response.data.msg;

		},

		logout(state){
			state.message = "You have been Logged out...";
			localStorage.removeItem("user");
			state.isLoggedIn = false;
			state.currentUser = null;
		},
		loadQuizzes(state,payload){
			if(payload.length == 0){
				state.message = "Pardon me! No more Quizzes."
			}
			else
			{
				state.quizzes = payload.data;
				state.pages = payload.last_page;
				state.currentPage = payload.current_page;

			}
		},
		loadQuestions(state,payload){
			state.questions = payload;
			
		},
		updateNextQuestion(state,payload){
			state.currentQuestion = state.questions[payload];
		},
		toggleLoading(state,bool){
			state.loading = bool;
		},
		showAlert(state,payload){
			state.message = payload;
		},
		storeScores(state,payload){
			state.result = payload;
		},
		setProfileDetails(state,payload){
			state.profileDetails = payload;
		},
		setAuthError(state,payload){
			state.authErr = payload;
		},
		setScores(state,payload){
			
			state.scoreboard = payload.scores;
			state.pages = payload.last_page;
			state.currentPage = payload.current_page;
		},
		setTimer(state,payload){
			state.timePeriod = payload;
		},
		setCurrentTime(state,payload){
			state.currentTime = payload;
		},
		setTimerObj(state,payload){
			state.timerObj = payload;
		}
	},
	actions:{
		login(context){
			context.commit("login");
		},
		register(context){
			context.commit("register");
		},
		loadQuizItems(context,options){
			context.commit("toggleLoading",true);
			if(options == null)
			{
				axios.get(baseurl+'/api/quiz/all')
				.then((response)=>{
					context.commit("toggleLoading",false);
					context.commit("loadQuizzes",response.data.quizzes);
				})
				.catch((error)=>{
					context.commit("toggleLoading",false);
					state.message = "Pardon me! No more Quizzes."
				})
			}
			else
			{
				axios.get(baseurl+'/api/quiz/all/?page='+options)
				.then((response)=>{
					context.commit("toggleLoading",false);
					context.commit("loadQuizzes",response.data.quizzes);
				})
				.catch((error)=>{
					context.commit("toggleLoading",false);
					state.message = "Pardon me! No more Quizzes."
				})
			}

		},
		loadQuizzersScores(context,options){
			context.commit("toggleLoading",true);
			if(options == null)
			{
				axios.get(baseurl+'/api/quiz/scores',{
					headers:{
						"Authorization":"Bearer "+context.state.currentUser.token
					}
				})
				.then((response)=>{
					context.commit("loadQuizzes",response.data.quizzes);
					context.commit("toggleLoading",false);
				})
				.catch((error)=>{
					context.commit("toggleLoading",false);
					state.message = "Pardon me! No more Quizzes."
				})
			}
			else
			{

				axios.get(baseurl+'/api/quiz/all/?page='+options,{
					headers:{
						"Authorization":"Bearer "+context.state.currentUser.token
					}
				})
				.then((response)=>{
					context.commit("toggleLoading",false);
					context.commit("loadQuizzes",response.data.quizzes);
				})
				.catch((error)=>{
					context.commit("toggleLoading",false);
					state.message = "Pardon me! No more Quizzes."
				})
			}

		},
		PlayQuiz(context,qid){
			context.commit("toggleLoading",true);
			context.quizId = qid;
			axios.get(baseurl+'/api/quiz/get/'+qid,{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("toggleLoading",false);
				if(response.data.questions.length > 0){
					context.commit("loadQuestions",response.data.questions);
					context.commit("updateNextQuestion",0);
					context.commit("setTimer",response.data.timePeriod);

				}
				else{
					context.commit("showAlert","Pardon me! No Questions...");
				}
			})

		},
		sendQuestionAnswers(context,payload){
			context.commit("toggleLoading",true);
			clearTimeout(context.state.timerObj);
			let quizId = payload[0];
			let questionIds = payload[1];
			let answerIds = payload[2];
			let time = context.state.currentTime;

			axios.post(baseurl+'/api/quiz/storeresults/'+quizId,{
				'questions':questionIds,
				'answers':answerIds,
				'time' :time
			},{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("toggleLoading",false);
				context.commit("storeScores",response.data);
			})
		},
		storeQuizQuestions(context,payload){
			context.commit("toggleLoading",true);
			context.commit("showAlert","Saving your quiz... Please be patient");
			axios.post(baseurl+'/api/quiz/storequizquestion',{
				'questions':payload[1],
				'quiz':payload[0]
			},{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("toggleLoading",false);
				if(response.data.quiz == null){
					context.commit("showAlert","Could not save quiz. Invalid Inputs");
				} else {
					context.commit("showAlert","Quiz "+response.data.quiz+" Added Success");
				}
			},(error)=>{
				context.commit("toggleLoading",false);
				context.commit("showAlert","Could not save quiz. Server error");

			})
			setTimeout(()=>{
				context.commit("showAlert","");

			},5000);
		},
		getProfile(context,payload){
			context.commit("toggleLoading",true);
			axios.get(baseurl+'/api/quiz/profile/'+payload,{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("setProfileDetails",response.data);
				context.commit("toggleLoading",false);

			},(error)=>{
				context.commit("showAlert","Error getting details...");
				context.commit("setAuthError",true);
				context.commit("toggleLoading",false);

			});
			
			setTimeout(()=>{
				context.commit("showAlert","");
				context.commit("setAuthError",false);


			},5000);
		},
		changePassword(context,payload){
			context.commit("showAlert","Changing Password...");
			context.commit("toggleLoading",true);
			axios.post(baseurl+'/api/auth/changepassword/'+context.state.currentUser.id,{
				password:payload
			},{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("showAlert","Password change Success");

			},(error)=>{
				context.commit("showAlert","Failed to change Password");

			});
			context.commit("toggleLoading",false);
			setTimeout(()=>{
				context.commit("showAlert","");

			},5000);
		},
		changeName(context,payload){
			context.commit("showAlert","Changing Name...");
			context.commit("toggleLoading",true);
			axios.post(baseurl+'/api/auth/changename/'+context.state.currentUser.id,{
				name:payload
			},{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.state.currentUser.name = response.data.name;
				context.commit("showAlert","Name change Success");

			},(error)=>{
				context.commit("showAlert","Failed to change Name");

			});
			context.commit("toggleLoading",false);
			setTimeout(()=>{
				context.commit("showAlert","");

			},5000);
		},
		getTopScores(context,options){
			context.commit("toggleLoading",true);
			if(options == null){
				axios.get(baseurl+'/api/quiz/scores/get',{
					headers:{
						"Authorization":"Bearer "+context.state.currentUser.token
					}
				})
				.then((response)=>{
					context.commit("toggleLoading",false);
					context.commit("setScores",response.data);
					context.commit("showAlert","Scoreboard loaded! have a look");

				},(error)=>{
					context.commit("toggleLoading",false);
					context.commit("showAlert","Server error. please try again");

				});
				
				setTimeout(()=>{
					context.commit("showAlert","");

				},5000);
			}
			else
			{
				axios.get(baseurl+'/api/quiz/scores/get/?page='+options,{
					headers:{
						"Authorization":"Bearer "+context.state.currentUser.token
					}
				})
				.then((response)=>{
					context.commit("toggleLoading",false);
					context.commit("setScores",response.data);
					context.commit("showAlert","Scoreboard loaded! have a look");

				},(error)=>{
					context.commit("toggleLoading",false);
					context.commit("showAlert","Server error. please try again");

				});
				setTimeout(()=>{
					context.commit("showAlert","");

				},5000);
			}
			

		},
		timerTicks(context,payload){
			
			context.commit("setCurrentTime",payload[1]);
			context.commit("setTimerObj",payload[0]);
		},
		DeleteQuiz(context,payload){
			context.commit("showAlert","Deleting...");
			context.commit("toggleLoading",true);
			if(context.state.currentUser.role != 'admin')
			{
				context.commit("showAlert","You cannot do this operation!");
				return false;
			}
			axios.get(baseurl+'/api/quiz/delete/'+payload,{
				headers:{
					"Authorization":"Bearer "+context.state.currentUser.token
				}
			})
			.then((response)=>{
				context.commit("toggleLoading",false);
				context.commit("showAlert","Quiz Deleted!");
				context.dispatch("loadQuizItems",null);

			},(error)=>{
				context.commit("toggleLoading",false);
				context.commit("showAlert","Server error. please try again");

			});
		}


	}
}