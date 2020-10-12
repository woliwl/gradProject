const Base = require('../base.js');
const axios = require('axios');
const URLEncoder = require('urlencode')
const weixin = require('../../config/config.js')

module.exports = class extends Base {
   async indexAction() {
        // let userlist = await this.model().table('user').select()
        let _w = weixin.weixin
        let data = this.post()
        let code = data.code
        // 获取用户id
        let userRes = await axios({
            url: _w.base_url + 'sns/jscode2session?',
            method: 'GET',
            params:{
                appid:'wx53fe927e0cd8cdae',
                secret:'1e925182dba4873cf814d69b2bcf1959',
                js_code:code,
                grant_type:'client_credential'
            }
        }).catch(err =>{
            console.log('获取用户id出错',err)
        })
        
        // 对昵称进行转码(带表情的昵称不能正常存入数据库)
        let obj = JSON.parse(data.userMsg)
        let openid = {openid:userRes.data.openid}
        let userID = {userID:userRes.data.openid}
        let user = {
            nickName:URLEncoder.encode(obj.nickName,"utf-8"),
            avatarUrl:obj.avatarUrl
        }
        let userMess = Object.assign(openid,user)
        // 存入数据库
        const result = await this.model('user').thenAdd(userMess, {openid: openid.openid});
        return this.json(openid)
   }
    
   
};
