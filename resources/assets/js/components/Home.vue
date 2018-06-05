<template>
	<div class="home">
		<div class="col-md-12 mb-3">
			<div class="card card-default">
				<div class="card-header bg-primary text-white"><strong>Play Quizzy...</strong></div>
				<div class="card-body">
					<h4 class="card-title">An Loyal Developers App</h4>
					<ul>
						<li>Create Quiz</li>
						<li>Play Quiz</li>
						<li>Check Scoreboard</li>
						<li>Share</li>
					</ul>
				</div>
			</div>
		</div>
		<div v-if="isLoading">
			<div class="row justify-content-center">
				<div class="col-md-1" v-if="isLoading">
					<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
				</div>
			</div>
		</div>
		<div v-else>
			<div class="justify-content-center mb-2" v-if="currentPage > 1">
				<button class="btn btn-success btn-block" @click="loadPrevious">
					Show Previous
				</button>
			</div>
			<div class="row">
			    <div class="col-md-4 mt-2"  v-for="q in quizzes">
			    	<div class="card card-default quiz-card">
			    		<div class="card-header">{{q.title}} <span class="badge badge-info pull-right tip">{{q.questCount}} <span class="tooltiptext">Question count</span></span> </div>
			    		    <div class="card-body">
								<h4 class="card-title">Play this quiz...</h4>
			    		        <button class="btn btn-outline-info btn-block" @click="PlayQuiz(q.id)"><i class="fa fa-play"></i> Play</button>
			    		    </div>
			    		    <div class="card-footer">
			    		    	Added on {{q.created_at}} by <span class="badge badge-primary">
			    		    		{{q.user_name}}
			    		    	</span>	
			    		    	<template v-if="currentUser">
			    		    		<button v-if="currentUser.role == 'admin'" @click="DeleteQuiz(q.id)" class="btn btn-danger btn-sm pull-right"><i class="fa fa-trash"></i></button>
			    		    	</template>
			    		    </div>
			    	</div>
			    </div>
			</div>
			<div class="justify-content-center mt-2" v-if="pages != currentPage">
				<button class="btn btn-success btn-block" @click="loadMore">
					Show Next
				</button>
			</div>
		</div>
	</div>
</template>
<script>
	export default{
		name:'home',
		data(){
			return{
				btnText:'Show More'
			}
		},
		methods:{
			loadMore(){
				this.$store.dispatch("loadQuizItems",this.currentPage+1);
			},
			loadPrevious(){
				this.$store.dispatch("loadQuizItems",this.currentPage-1);
			},
			PlayQuiz(id){
				this.$router.push({
					path:'/quiz/'+id
				});
			},
			DeleteQuiz(id){
				this.$store.dispatch("DeleteQuiz",id);

			}
		},
		computed:{
			quizzes(){
				return this.$store.state.quizzes;
			},
			pages(){
				return this.$store.state.pages;
			},
			currentPage(){
				return this.$store.state.currentPage;

			},
			currentUser(){
				return this.$store.getters.currentUser;
			},
			isLoading(){
				return this.$store.getters.isLoading;
			}
		},
		mounted(){
			this.$store.dispatch("loadQuizItems");
		}
	}
</script>
<style scoped>
	.quiz-card{

	}
	.quiz-card:hover{
		box-shadow: 2px 3px 2px 3px #1adda4;
		transition-duration: 0.5s;
	}
	.tip {
	    position: relative;
	    display: inline-block;
	    border-bottom: 1px dotted black;
	}

	.tip .tooltiptext {
	    visibility: hidden;
	    width: 120px;
	    background-color: black;
	    color: #fff;
	    text-align: center;
	    border-radius: 6px;
	    padding: 5px 0;

	    /* Position the tooltip */
	    position: absolute;
	    z-index: 1;
	}

	.tip:hover .tooltiptext {
	    visibility: visible;
	}
</style>