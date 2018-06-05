<template>
	<div class="timer">
		<div class="col-md-12 mb-3">
			<div class="card card-default">
				<div class="card-header bg-primary text-white"><strong><i class="fa fa-time"></i> Time Left: {{label}} ...</strong></div>
				<div class="card-body">
					<div class="progress">
					  <div class="progress-bar progress-bar-striped progress-bar-animated " :class="state" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"  v-bind:style="{ width : tick + '%' }"><strong>{{label}}</strong></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
	export default{
		name:'timer',
		props:['timePeriod'],
		data(){
			return{
				label:'',
				state:'',
				tick:0,
				timer:null
			}
		},
		mounted(){
			let tp = this.timePeriod;
			let i = 0;
			let sec = 59;
			let mins = tp-1;
			let milisec = tp*60000/1;
			milisec = milisec-tp*1000;
			//this timer function executes each second
			this.timer = setInterval(()=>{
				i += 1000
				this.tick = i/milisec*100;
				 //tick second is timer tick
				 sec--;
				 if(sec == 0){
				 	mins = mins-1;
				 	sec = 59;
				 }
				 if(mins == 0){
				 	this.label = 'only '+sec+' seconds. Hurry!';
				 }
				 else
				 {
					this.label = mins+' Minutes and '+sec+' seconds';
				 }
				if(mins < 2)
				{
					this.state = 'bg-warning'
				}
				//console.log(this.tick)
				//console.log(this.$store.getters.getQuestions)
				this.$store.dispatch("timerTicks",[this.timer,mins+":"+sec]);
			},1000);
			//this code will execute after the time period ended

			setTimeout(()=>{
				clearTimeout(this.timer);
				this.label = "Your Times Up"
				this.state = 'bg-danger'
				this.$store.commit("showAlert","Failed! Your Time is over");
				this.$router.push({
					path:'/'
				});
			},milisec);//this millisec variable is ur formula
		}
	}
</script>
