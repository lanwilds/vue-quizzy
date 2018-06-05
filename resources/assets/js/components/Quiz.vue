<template>
	<div class="home">
		<div v-if="isLoading" style="text-align:center;">
			<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
		</div>
		<div v-else>
			<Timer v-if="timePeriod > 0" :time-period="timePeriod"/>
			<div class="row">
			    <div class="col-md-12 mt-2">
			    	<div class="card card-default">
			    		<div class="card-header bg-primary text-white">
			    			Answer Question
			    		</div>
			    		    <div class="card-body">
								<h4 class="card-title">{{currentQuestionNo}}. {{getQuestions.question}}</h4>
								<form>
									<div class="form-group" v-for="ch in getQuestions.choices">
									  <div class="custom-control custom-radio">
									    <input type="radio" :id="ch.id" name="option" class="custom-control-input" :value="ch.id" v-model="option">
									    <label class="custom-control-label" :for="ch.id"> {{ch.choice}}</label>
									  </div>
									 </div>
								</form>
								<template v-if="currentQuestionNo+1 >totalQuestions">
									<button type="button" class="btn btn-outline-info btn-block" @click="loadNextQuestion"> Finish <i class="fa fa-forward"></i></button>
								</template>
								<template v-else>
									<button type="button" v-bind:class="{disabled:option == null}" class="btn btn-outline-info btn-block " @click="loadNextQuestion"> Next <i class="fa fa-forward"></i></button>
								</template>
			    		        
			    		    </div>
			    		    <div class="card-footer">
			    		    	Total Questions {{getTotalQuestions}}
			    		    </div>
			    	</div>
			    </div>
			</div>
		</div>
	</div>
</template>
<script>
import Timer from './partials/Timer.vue';
	export default{
		name:'home',
		data(){
			return{
				tick:0,
				label:'Time is running...',
				state:'',
				totalQuestions:0,
				currentQuestionNo:1,
				option:null,
				optionId:null,
				questionId:null,
				questions:[],
				currentQuestion:[],
				currentQuestionId:null,
				showQuest:false,
				answerIds:[],
				questionIds:[],
				quizId:null
			}
		},
		components:{
			Timer
		},
		methods:{
			getDataReady(questionId,option){
				
				this.questionIds.push(questionId);
				this.answerIds.push(option);
			},
			loadNextQuestion(){
				if(this.currentQuestionNo+1> this.totalQuestions){
					this.getDataReady(this.currentQuestionId,this.option);
					this.FinishQuiz();
					return false;
				}
				if(this.option == null){
					return false;
				}
				else
				{
					this.getDataReady(this.currentQuestionId,this.option);
					this.$store.commit("updateNextQuestion",this.currentQuestionNo);
					this.currentQuestionNo +=1;
					this.option = null;
				}
			},
			FinishQuiz(){
				this.$router.push({
					path:'/results'
				});
				this.$store.dispatch("sendQuestionAnswers",[this.quizId,this.questionIds,this.answerIds]);

			}
		},
		computed:{
			isLoading(){
				return this.$store.getters.isLoading;
			},
			getQuestions(){
				this.currentQuestionId = this.$store.getters.getCurrQuestions.id;
				return this.$store.getters.getCurrQuestions;
			},
			getTotalQuestions(){
				this.totalQuestions = this.$store.getters.getQuestions.length;
				return this.$store.getters.getQuestions.length;
			},
			hasError(){
				return this.$store.getters.getMessage;
			},
			timePeriod(){
				return this.$store.getters.getTimer;
			}
		},
		created(){

		},
		mounted(){
			this.showQuest = true;
			this.quizId = this.$route.params.id;
			if(isNaN(this.quizId) || this.quizId < 1){
				this.$router.push({
					path:'/'
				});
				return false;
			}
			this.$store.dispatch("PlayQuiz",this.$route.params.id);





		}
	}
</script>
<style scoped>

</style>