export function initialize(store,router){
	router.beforeEach((to,from,next)=>{
		const requiresAuth = to.matched.some(record => record.meta.requiresAuth );
		const currentUser = store.state.currentUser;

		if(requiresAuth && !currentUser){
			store.commit("showAlert","You need to login for accessing this content. new user ? register now")
			next('/login');
		} else if(to.path == '/login' && currentUser){
			next('/');
		} else {
			next();
		}
		setTimeout(()=>{
			store.commit("showAlert","")
		},5000)
	});

	axios.interceptors.response.use(null,(error)=>{
		if(error.response.status == 401){
			store.commit('logout');
			router.push('/login');
		}
		return Promise.reject(error);
	});
}