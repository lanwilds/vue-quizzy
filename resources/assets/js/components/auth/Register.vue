<template>
	<div class="login">
		<div class="row justify-content-center">
				<div class="col-md-1" v-if="isLoading">
					<img src="http://lanwildsouza.tk/quizzy/spinner.gif" height="140px" width="140px">
				</div>
			   <div class="col-md-8" v-else>
		        <div class="card card-default">
		            <div class="card-header bg-info text-white">Register to Quizzy</div>
		            <form @submit.prevent="register">
		            	<div class="card-body">
		            		<div class="alert alert-warning alert-dismissible fade show" role="alert" v-if="errors">
		            			<ul>
		            				<li v-for="(fieldsError,fieldsName) in errors" :key="fieldsName">
		            					<strong>{{ fieldsName }}</strong> :{{fieldsError.join('\n')}}
		            				</li>
		            			</ul>

		            			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		            			  <span aria-hidden="true">&times;</span>
		            			</button>
		            		</div>
		            		<div class="form-group">
		            				<label for="email">Name</label>
		            				<input type="text" name="name" class="form-control" v-model="form.name" placeholder="Enter Name">
		            		</div>
		            	   <div class="form-group">
		            	   		<label for="email">Email</label>
		            	   		<input type="text" name="email" class="form-control" v-model="form.email" placeholder="Enter Email">
		            	   </div>
		            	   <div class="form-group">
		            	   		<label for="password">Password</label>
		            	   		<input type="password" name="password" class="form-control" v-model="form.password" placeholder="Enter Password">
		            	   </div>
		            	   <div class="form-group">
		            	   		<label for="repassword">RePassword</label>
		            	   		<input type="password" name="repassword" class="form-control" v-model="form.repassword" placeholder="Re-enter Password">
		            	   </div>
		            	   <button class="btn btn-info btn-block" type="submit">Register</button>
		            	</div>
		            </form>
		            <div class="card-footer">
		            	Register and Start Quizzy
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</template>
<script>
import {register} from '../../helpers/auth';
import validate from 'validate.js';
export default{
	data(){
		return{
			form:{
				email:'',
				password:'',
				repassword:'',
				name:''
			},
			errors:null
		};
	},
	methods:{
		register(){
			this.errors="";
			const constraints = this.getConstraints();

			const error = validate(this.$data.form,constraints);
			if(error){
				this.errors = error;
			}
			else
			{
				this.registerDetails();
			}

			setTimeout(()=>{
				this.errors = '';
			},3000)
		
		},
		getConstraints(){
			return {
				name:{
					presence:true,
					length:{
						minimum:3
					}
				},
				email:{
					presence:true,
					email:true
				},
				password:{
					presence:true,
					length:{
						minimum:6
					}
				},
				repassword: {
					presence:true,
				  	equality: "password"
				}
			}
		},
		registerDetails(){
			this.$store.dispatch("register");

			register(this.$data.form)
			.then((res)=>{
				this.$store.commit("registerSuccess",res);
				this.$router.push({
					path:'/login'
				});
			})
			.catch((error)=>{
				this.$store.commit("registerFailed",{error});
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