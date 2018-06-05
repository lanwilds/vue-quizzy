import Home from './components/Home.vue';
import Login from './components/auth/Login.vue';
import Register from './components/auth/Register.vue';
import Quiz from './components/Quiz.vue';
import CreateQuiz from './components/CreateQuiz.vue';
import Result from './components/Result.vue';
import Profile from './components/Profile.vue';
import Scoreboard from './components/Scoreboard.vue';

export const routes = [
	{
		path:'/',
		component: Home,
		
	},
	{
		path:'/quiz/:id',
		component: Quiz,
		meta:{
			requiresAuth:true
		}
	},
	{
		path:'/create/quiz',
		component: CreateQuiz,
		meta:{
			requiresAuth:true
		}
	},
	{
		path:'/results',
		component: Result,
		meta:{
			requiresAuth:true
		}
	},
	{
		path:'/scoreboard',
		component: Scoreboard,
		meta:{
			requiresAuth:true
		}
	},
	{
		path:'/profile/:id',
		component: Profile,
		meta:{
			requiresAuth:true
		}
	},
	{
		path:'/login',
		component:Login
	},
	{
		path:'/register',
		component:Register
	},
	{
	  path: '*',
	  component: Home
	}
];