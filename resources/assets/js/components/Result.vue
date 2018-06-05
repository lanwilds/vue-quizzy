<template>
	<div class="result">
		<div class="col-md-12 mb-3">
			<div style="text-align:center;" v-if="isLoading">
				<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
			</div>
			<div class="card card-default" v-else>
				<div class="card-header bg-primary text-white"><strong>Your Result</strong></div>
				<div class="card-body">
					Yuppie... you've got <span class="badge badge-success">{{scores.score}}</span> out of  <span class="badge badge-success">{{scores.totalQuestions}}</span> in <span class="badge badge-warning">{{scores.attempts}}</span> Attempts.
					Finished Time {{getCurrentTime}}
				</div>
				<div class="card-footer">
					 <router-link to="/" class="btn btn-primary"><i class="fa fa-home"></i> Go Back</router-link>	
					  <router-link to="/scoreboard" class="btn btn-info"><i class="fa fa-list"></i> Scoreboard</router-link>	
				</div>
			</div>
		</div>
	</div>
</template>
<script>
	export default{
		name:'result',
		data(){
			return{

			}
		},
		methods:{

		},
		computed:{
			isLoading(){
				return this.$store.getters.isLoading;
			},
			scores(){
				if(this.$store.getters.getScores.length == 0){
					console.log(this.$store.getters.getScores);
					this.$router.push({
						path:'/'
					});
				}
				return this.$store.getters.getScores;
			},
			getCurrentTime(){
				return this.$store.getters.getCurrentTime;
			}
		},
		mounted(){
			
			//this.$store.dispatch("loadQuizItems");
		}
	}
</script>
<style scoped>

</style>