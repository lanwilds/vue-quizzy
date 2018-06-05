<template>
	<div class="scoreboard">
		
		<div class="row justify-content-center">
			<div class="col-md-1" v-if="isLoading">
				<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
			</div>
		    <div class="col-md-10" v-else>
		        <div class="card card-default">
		        	<div class="card-header bg-success text-white">Scoreboard</div>
		        	<div class="row justify-content-center m-2" v-if="currentPage > 1">
		        		<button class="btn btn-info" @click="loadPrevious">
		        			Show Previous
		        		</button>
		        	</div>
		        	<div class="card-body" style="overflow:scroll;">
		        		<table class="table table-hover">
		        		  <thead>
		        		    <tr>
		        		      <th scope="col">Quiz</th>
		        		      <th scope="col">#1</th>
		        		      <th scope="col">#2</th>
		        		      <th scope="col">#3</th>
		        		    </tr>
		        		  </thead>
		        		  <tbody>
		        		    <tr class="table-active" v-for="q in scores">
		        		      <th scope="table-active">{{q.quizTitle}}</th>
		        		      	<td v-for="user in q.scores">
		        		      		<span class="badge badge-primary">{{user.score}}</span> scores in <span class="badge badge-info">{{user.attempt}}</span> attempts by
		        		      	<span class="badge badge-success">{{user.users.name}}</span>
		        		      	at time 
		        		      	<span class="badge badge-success">{{q.scores[0].time}} minutes</span>
		        		      	</td>
		        		    </tr>
		        		</tbody>
		        	</table>
		        	</div>
		        	<div class="row justify-content-center m-2" v-if="pages != currentPage">
		        		<button class="btn btn-info" @click="loadMore">
		        			Show More
		        		</button>
		        	</div>
		        </div>
		    </div>
		</div>
	</div>
</template>
<script>
export default{
	methods:{
		loadMore(){
			this.$store.dispatch("getTopScores",this.currentPage+1);
		},
		loadPrevious(){
			this.$store.dispatch("getTopScores",this.currentPage-1);
		}
	},
	computed:{
		pages(){
			return this.$store.state.pages;
		},
		currentPage(){
			return this.$store.state.currentPage;

		},
		scores(){
			return this.$store.getters.getQuizzyScores;
		},
		isLoading(){
			return this.$store.getters.isLoading;
		}
	},
	mounted(){
		this.$store.dispatch("getTopScores");
		//this.$store.dispatch("getTopScores");
	}
}
</script>