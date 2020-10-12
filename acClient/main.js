import Vue from 'vue'
import App from './App'
import myRequest from './common/request.js'
import './static/aliIcon/iconfont.css'
Vue.prototype.$myRequest = myRequest
Vue.config.productionTip = false
App.mpType = 'app'

const app = new Vue({
	...App
})
app.$mount()
