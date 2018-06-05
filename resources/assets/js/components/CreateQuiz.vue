<template>
	<div class="createQuiz">
		<div class="row justify-content-center">
		    <div class="col-md-8">
		        <div class="card card-default" v-if="!showQuestionForm">
		            <div class="card-header bg-info text-white">Create new Quizz</div>
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
		            				<label for="email">Add a Title</label>
		            				<input type="text" name="title" class="form-control" v-model="form.title" placeholder="Enter title">
		            		</div>
		            		<div class="form-group">
		            				<label for="email">Add time period</label>
		            				<input type="text" name="time" class="form-control" v-model="form.time" placeholder="Enter Time">
		            		</div>
		            	   <button class="btn btn-info btn-block " v-bind:class="{disabled :form.title == null}"   @click="createQuiz">Next
		            	   </button>
		            	</div>
		        </div>
		        <div class="card card-default" v-else>
		            <div class="card-header bg-info text-white">Add Questions for {{form.title}}</div>
		            	<div class="card-body">
		            		<div class="alert alert-warning alert-dismissible fade show" role="alert" v-if="qErrors">
		            			<ul>
		            				<li v-for="(fieldsError,fieldsName) in qErrors" :key="fieldsName">
		            					<strong>{{ fieldsName }}</strong> :{{fieldsError.join('\n')}}
		            				</li>
		            			</ul>

		            			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		            			  <span aria-hidden="true">&times;</span>
		            			</button>
		            		</div>
		            		<div class="alert alert-primary" role="alert" v-if="alert">
		            			{{alert}}
		            		</div>
		            		<div class="form-group">
		            				<label for="question">{{questionCount}}. Add Question</label>
		            				<input type="text" name="question" class="form-control" v-model="question.title" placeholder="Enter Question" required="required">
		            		</div>
		            		<div class="form-group">
		            				<label for="choices"> Add Choices</label>
		            				<input type="text" name="question" class="form-control mb-1" v-model="question.choices[0]" placeholder="Enter Question" required="required">
		            				<input type="text" name="question" class="form-control mb-1" v-model="question.choices[1]" placeholder="Enter Question" required="required">
		            				<input type="text" name="question" class="form-control mb-1" v-model="question.choices[2]" placeholder="Enter Question" required="required">
		            				
		            		</div>
		            		<div class="form-group">
		            				<label for="rightchoices">Select Right Choice</label>
		            				<select class="form-control" v-model="question.rightChoice" required="required">
		            					<option value="">Select a choice</option>
		            					<option v-for="c in question.choices" :value="question.choices.indexOf(c)">{{c}}</option>
		            				</select>
		            				
		            		</div>
		            	   <button class="btn btn-primary btn-block " @click="addQuestion">Next
		            	   </button>
		            	   <button class="btn btn-info btn-block " @click="finishAdding" v-if="questionCount > 1">Finish
		            	   </button>
		            	</div>
		        </div>
		    </div>
		</div>
	</div>
</template>
<script>

import validate from 'validate.js';
export default{
	data(){
		return{
			showQuestionForm:false,
			questionCount:1,
			form:{
				title:null,
				time:null
			},
			question:{
				title:'',
				rightChoice:'',
				choices:[]
			},
			questions:[],
			errors:null,
			alert:'',
			qErrors:null
		};
	},
	methods:{
		createQuiz(){
			this.errors="";
			const constraints = this.getConstraints();

			const error = validate(this.$data.form,constraints);
			if(error){
				this.errors = error;
			}
			else
			{
				this.showQuestionForm = true;
			}

			setTimeout(()=>{
				this.errors = '';
			},5000)
		
		},
		getConstraints(){
			return {
				title:{
					presence:true,
					length:{
						minimum:5
					}
				},
				time:{
					presence:true,
					length:{
						minimum:1,
						maximum:2
					},
					numericality:{
						onlyInteger:true,
						lessThanOrEqualTo:60,
						greaterThan:0
					}
				}
			}
		},
		addQuestion(){
			if(this.question.choices[0] === this.question.choices[1] || this.question.choices[0] === this.question.choices[2] || this.question.choices[1] === this.question.choices[2] ){
				this.alert = "Choices cannot be the same";
				setTimeout(()=>{
					this.alert = '';
				},5000)
				return false;
			}
			if(this.question.choices[0] === ''|| this.question.choices[1] ==='' || this.question.choices[2] === ''  ){
				this.alert = "Choices cannot be empty";
				setTimeout(()=>{
					this.alert = '';
				},5000)
				return false;
			}
			const Questionerrors = validate(this.$data.question,{
				choices:{
					presence:true,
					length:{
						minimum:3
					}
				},
				rightChoice:{
					presence:true,
					numericality:{
						onlyInteger:true,
						lessThanOrEqualTo:2
					}
				},
				title:{
					presence:true,
					length:{
						minimum:3
					}
				}
			});
			if(Questionerrors){
				this.qErrors = Questionerrors;
				
				setTimeout(()=>{
					this.qErrors = null;
				},3000)
				return false;
			}
			let questionArray = {
				title:this.question.title,
				choices:[
					this.question.choices[0],
					this.question.choices[1],
					this.question.choices[2],
				],
				rightChoice:this.question.rightChoice

			};
			if(this.questionCount == 15){
				this.alert="Max Question limit exceeded. Please Continue to finish"
				setTimeout(()=>{
					this.alert = null;
				},3000);
				return false;
			}
			this.questions.push(questionArray);
			this.questionCount += 1;
			this.clearInputs();

		},
		finishAdding(){
			this.addQuestion();
			this.$store.dispatch("storeQuizQuestions",[this.form,this.questions]);
			this.$router.push({
				path:'/'
			});
			//console.log(this.questions);
		},
		clearInputs(){
			this.question.title = '';
			this.question.choices[0] = '';
			this.question.choices[1] = '';
			this.question.choices[2] = '';
			this.question.rightChoice = '';
		}
	},
	computed:{
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