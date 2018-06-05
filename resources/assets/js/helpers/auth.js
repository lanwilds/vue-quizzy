export function login(credentials){
	return new Promise((res,rej)=>{
		axios.post(baseurl+"/api/auth/login",credentials)
		.then((response)=>{
			res(response.data)
		})
		.catch((err)=>{
			rej("Incorrect Login credentials")
		})
	})
}
export function register(credentials){
	return new Promise((res,rej)=>{
		axios.post(baseurl+"/api/auth/register",credentials)
		.then((response)=>{
			res(response.data)
		})
		.catch((err)=>{
			rej(err)
		})
	})
}
export function getLocalUser(){
	const userStr = localStorage.getItem("user");
	if(!userStr){
		return null;
	}

	return JSON.parse(userStr);
}