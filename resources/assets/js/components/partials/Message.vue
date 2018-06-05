<template>
	<div class="msg">
		<div class="alert alert-primary alert-dismissible fade show" role="alert" v-if="getMessage">
			{{ getMessage }}

			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			  <span aria-hidden="true">&times;</span>
			</button>

		</div>
	</div>
</template>
<script>
export default{
	data(){
		return{
			hide:true
		}
	},
	computed:{
		getMessage(){
			return this.$store.getters.getMessage;
		}
	}
}
</script>
<style scoped>
	
</style>