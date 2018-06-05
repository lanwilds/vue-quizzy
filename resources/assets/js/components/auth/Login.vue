<template>
	<div class="login">
		<div class="row justify-content-center">
			<div class="col-md-1" v-if="isLoading">
				<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
			</div>
		    <div class="col-md-8" v-else>
		        <div class="card card-default">
		            <div class="card-header bg-primary text-white">Login to Quizzy</div>
		            <form @submit.prevent="authenticate">
		            	<div class="card-body">
		            		<div class="alert alert-warning alert-dismissible fade show" role="alert" v-if="authError">
		            			{{ authError }}

		            			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		            			  <span aria-hidden="true">&times;</span>
		            			</button>

		            		</div>
		            	   <div class="form-group">
		            	   		<label for="email">Email</label>
		            	   		<input type="text" name="email" class="form-control" v-model="form.email" placeholder="Enter Email">
		            	   </div>
		            	   <div class="form-group">
		            	   		<label for="email">Password</label>
		            	   		<input type="password" name="password" class="form-control" v-model="form.password" placeholder="Enter Password">
		            	   </div>
		            	   <button class="btn btn-outline-primary btn-block" type="submit">Login</button>
		            	</div>
		            </form>
		            <div class="card-footer">
		            	Login and Start Quizzy
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</template>
<script>
import {login} from '../../helpers/auth';
export default{
	data(){
		return{
			form:{
				email:'',
				password:''
			},
			error:null,
		};
	},
	methods:{
		authenticate(){
			this.$store.dispatch("login");

			login(this.$data.form)
			.then((res)=>{
				this.$store.commit("loginSuccess",res);
				this.$router.push({
					path:'/'
				});
			})
			.catch((error)=>{
				this.$store.commit("loginFailed",{error});
			})
		}
	},
	computed:{
		authError(){
			return this.$store.getters.authError;
		},
		isLoading(){
			return this.$store.getters.isLoading;
		}
	},
	mounted(){

	}
}
</script>
<style scoped>
	
</style>