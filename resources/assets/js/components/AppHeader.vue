<template>
	<div class="header">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		  <a class="navbar-brand" href="#">Quizzy</a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>

		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      <li class="nav-item active">
		       <router-link to="/" class="nav-link"><i class="fa fa-home"></i> Home</router-link>	
		      </li>
		      <li class="nav-item">
		       <router-link to="/scoreboard" class="nav-link"><i class="fa fa-list"></i> Scoreboard</router-link>	
		      </li>

		    </ul>
		    <template v-if="currentUser">
		    	<ul class="navbar-nav mr-5">
		    		<li class="nav-item dropdown">
		    		  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    		   <i class="fa fa-user-circle-o"></i> {{currentUser.name}}
		    		  </a>
		    		  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		    		 	<router-link :to="profileLink" class="dropdown-item"><i class="fa fa-user"></i> My Profile</router-link>	
		   		 		<router-link to="/create/quiz" class="dropdown-item"><i class="fa fa-plus"></i> Create Quiz</router-link>		
		    		    <div class="dropdown-divider"></div>
		    		    <a class="dropdown-item" href="#" @click.prevent="logout"><i class="fa fa-sign-out"></i> Logout</a>
		    		  </div>
		    		</li>
		    	</ul>
		    </template>
		    <template v-else>
		    	<ul class="navbar-nav mr-5">
		    		 <li class="nav-item">
		    		 	<router-link to="/login" class="nav-link">Login</router-link>		
		      		</li>
		      		<li class="nav-item">
		    		 	<router-link to="/register" class="nav-link">Register</router-link>	
		      		</li> 		
		    	</ul>
		    </template>
		  </div>
		</nav>
	</div>
</template>
<script>
export default{
	name:'app-header',
	methods:{
		logout(){
			this.$store.commit('logout');
			this.$router.push({
				path:'/login'
			})
		}
	},
	computed:{
		currentUser(){
			return this.$store.getters.currentUser;
		},
		profileLink(){
			return this.$store.getters.getProfileLink;
		}
	}
}
</script>
<style scoped>
	.header{
		margin-bottom: 2%;
	}
</style>