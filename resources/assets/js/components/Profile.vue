<template>
	<div class="profile">
		<div  v-if="isLoading" style="text-align:center;">
			<img src="http://lanwildsouza.tk/quizzy/img/spinner.gif" height="140px" width="140px">
		</div>
		<div class="row justify-content-center" v-if="!hasError && !isLoading">
		    <div class="col-md-8">
		        <div class="card card-default">
		        	<div class="card-header bg-success text-white">Profile</div>
		        	<div class="card-body">
		        		<div class="form-group ">
		        			<label for="name">Name</label>
		        			<input class="form-control" type="text" readonly :value="getProfile.user.name">
		        		</div>
		        		<div class="form-group">
		        			<label for="email">Email</label>
		        			<input class="form-control" type="text" readonly :value="getProfile.user.email">
		        		</div>
		        		<div class="form-group">
		        			<label for="Role">Role</label>
		        			<input class="form-control" type="text" readonly :value="getProfile.user.role">
		        		</div>
		        		<div class="form-group">
		        			<label for="quiz">Quizzes Created so far</label>
		        			<input class="form-control" type="text" readonly :value="getProfile.quizCreated">
		        		</div>
		        		<div class="form-group">
		        			<label for="quizPlay">Quizzes Played so far</label>
		        			<input class="form-control" type="text" readonly :value="getProfile.quizPlayed">
		        		</div>
		        	</div>
		        </div>
		    </div>
		    <div class="col-md-4">
		    	<div class="alert alert-primary" v-if="alertError">{{alertError}}</div>
		        <div class="card card-default">
		        	<div class="card-header bg-info text-white">Change Name</div>
		        	<div class="card-body">
		        		<div class="form-group">
		        			<label for="name">Change Name</label>
		        			<input class="form-control" name="name" v-model="name" type="text" placeholder="Change Name">
		        		</div>
		        		<button class="btn btn-info" @click="changeName">Change</button>
		        	</div>
		        </div>
		        <div class="card card-default mt-2">
		        	<div class="card-header bg-primary text-white">Change Password</div>
		        	<div class="card-body">
		        		<div class="form-group">
		        			<label for="pwd">Password</label>
		        			<input class="form-control" name="pwd" v-model="pwd" type="password">
		        		</div>
		        		<div class="form-group">
		        			<label for="rpwd">Re-enter Password</label>
		        			<input class="form-control" name="rpwd" v-model="rpwd" type="password">
		        		</div>
		        		<button class="btn btn-primary" @click="changePassword">Submit</button>
		        	</div>
		        </div>
		    </div>
		</div>
	</div>
</template>
<script>
	export default{
		data(){
			return{
				name:'',
				pwd:null,
				rpwd:null,
				alertError:''
			}
		},
		methods:{
			changePassword(){
				if(this.pwd == null || this.rpwd == null)
				{
					this.alertError="Password Field must not be empty";
					return false;
				}
				if(this.pwd != this.rpwd)
				{
					this.alertError="Password Fields must match";
					return false;
				}
				if(this.pwd.length < 6)
				{
					this.alertError="Password Fields must be atleast 6 character long";
					return false;
				}
				this.$store.dispatch("changePassword",this.pwd);
				this.LoadProfile();
				setTimeout(()=>{
					this.alertError = '';
					this.pwd ='';
					this.rpwd='';
				},1000)

			},
			changeName(){
				if(this.name == null)
				{
					this.alertError="Name Field must not be null";
					return false;
				}
				if(this.name.length < 3)
				{
					this.alertError="Name must be atleast 3 character long ";
					return false;
				}
				this.$store.dispatch("changeName",this.name);
				this.LoadProfile();
				setTimeout(()=>{
					this.alertError = '';
					this.name ='';
				},3000)
			},
			LoadProfile(){
				this.$store.dispatch("getProfile",this.$route.params.id);
			},
			RouteBack(){
				this.$router.push({
					path:"/"
				});
			}
		},
		computed:{
			getProfile(){
				return this.$store.getters.getProfileDetails;
			},
			hasError(){
				if(this.$store.getters.authError == true){
					this.RouteBack();
				}
				return this.$store.getters.authError;
			},
			isLoading(){
				return this.$store.getters.isLoading;
			}
		},
		mounted(){
			this.LoadProfile();
		}
	}
</script>