const Base = require('../base.js');
const axios = require('axios');
const URLEncoder = require('urlencode')

module.exports = class extends Base {
    // 创建家庭
    async createFamAction(){
        //随机生成一个不重复的字符串作为家庭号        
        function randomString(length) {
          var str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
          var result = '';
          for (var i = length; i > 0; --i) 
            result += str[Math.floor(Math.random() * str.length)];
          return result;
        }
        
        let data = this.post()
        let famNum = {famNum:randomString(6)} 
        
        // 放入数据库(家人表families，家庭表)
        let fam_data = Object.assign(data,famNum)
        await this.model('families').add(fam_data)
        await this.model('home').add(fam_data)
        // 返回的参数
        return this.json(famNum)
    }
    
    // 创建或加入同时添加一个同步账单功能---“是否同步你的历史账单至***家庭”
    async isUploadAction(){
        let data = this.post()
        let bill = await this.model('person_bill').where({
            openid:data.openid
        }).select()
        let famNum = {famNum:data.famNum}
        console.log(famNum)
        if(data.famNum != ''){
            bill.forEach(async el =>{
                el = Object.assign(el,famNum)
                await this.model('families_bill').add(el)
                // console.log(el)
            })
            return this.json('yes')
        }else{
            return this.json('no')
        }        
    }
    
    // 加入家庭-----查询
    async findFamAction(){
        let data = this.post()
        let res = await this.model('families').where(data).find()
        return this.json(res.famName)
    }
    
    // 加入家庭-----加入
    async joinFamAction(){
        let data = this.post()
        let where = {openid: data.openid,famNum:data.famNum}
        let res  = await this.model('families').thenAdd(data,where);
        return this.json(res.type)
    }
    
    // 获取家庭
    async indexAction(){
        let data = this.post()
        // 通过openid查询该用户是否创建或加入家庭
        let isfam = await this.model('families').where(data).select()
        let resData = []
        if (isfam.length == 0) {
            return this.json("not")
        } else{
            for(let i=0; i<isfam.length; i++){
                let famNum = {famNum:isfam[i].famNum}
                let res = await this.model('home').where(famNum).find()
                resData.push(res)
            }
            return this.json(resData)
        }
    }
    
    // 删除家庭
    // 删除家庭的同时一并删除家人，家庭账单信息
    async delFamAction(){
        let data = this.post()
        let home = await this.model('home').where(data).delete(),
            fams = await this.model('families').where(data).delete(),
            famsbill = await this.model('families_bill').where(data).delete()
        return this.json('success')
    }
    // 获取家人
    async getFamsAction(){
        let data = this.post()
        // 查询家人列表
        let famlist = await this.model('families').where(data).select()
        return this.json(famlist)
    }
    
    // 退出家庭
    async outHomeAction(){
        let data = this.post()
        await this.model('families').where(data).delete()
        await this.model('families_bill').where(data).delete()
        return this.json(data)
    }
};