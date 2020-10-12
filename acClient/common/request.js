import uniRequest1 from 'uni-request';
let baseURL='http://127.0.0.1:8360';
function myRequest(options){
	let headers={}
	var Token =uni.getStorageSync('Token');
	var UserId =uni.getStorageSync('UserId');
	
	headers['HBWS-Client-Token'] = Token;
	headers['HBWS-Client-UserId'] = UserId;
	headers["Content-Type"] = "application/json";
	return new Promise((res,rej)=>{
		uni.request({
			url:baseURL + options.url,
			method:options.method || 'GET',
			data:options.data,
			header:headers,
			success(data) {
				res(data)
			},
			fail() {
				rej()
			}
		})
	})
	
}
export default myRequest;