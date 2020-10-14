const Base = require('../base.js');

// 显示页面
module.exports = class extends Base {
  async getIconsInAction() {
    let iconsIn = await this.model('class').where({quality:'0'}).order('icon_id DESC').select()
    return this.json(iconsIn)
  }
  async getIconsOutAction() {
    let iconsOut = await this.model('class').where({quality:'1'}).order('icon_id DESC').select()
    return this.json(iconsOut)
  }
  
  // 记账
  async createBillAction() {
      let data = this.post()
      //随机生成一个不重复的字符串作为账单id
      function randomString(length) {
        var str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        var result = '';
        for (var i = length; i > 0; --i) 
          result += str[Math.floor(Math.random() * str.length)];
        return result;
      }
      let id = {id:randomString(10)}
      let perbill = Object.assign(data,id)
      await this.model('person_bill').add(perbill)
      // 判断该用户是否创建/加入家庭，是则上传至家庭账单
      let openid = {openid:data.openid}
      let res = await this.model('families').where(openid).select()
      if (res.length == 0) {
          console.log("该用户没有家庭，无需上传家庭账单")
      } else{
          let fambillArr = []
          for(let i=0;i<res.length;i++){
              let famNum = {famNum:res[i].famNum}
              let fambill = Object.assign(famNum,perbill)
              fambillArr.push(fambill)
          }
          await this.model('families_bill').addMany(fambillArr)
      }
  }
  
  // 记录债务
  async createDebtsAction() {
      let data = this.post()
      //随机生成一个不重复的字符串作为账单id
      function randomString(length) {
        var str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        var result = '';
        for (var i = length; i > 0; --i) 
          result += str[Math.floor(Math.random() * str.length)];
        return result;
      }
      let id = {id:randomString(10)}
      let perdebt = Object.assign(data,id)
      await this.model('person_debt').add(perdebt)
      // 判断该用户是否创建/加入家庭，是则上传至家庭账单
      let openid = {openid:data.openid}
      let res = await this.model('families').where(openid).select()
      if (res.length == 0) {
          console.log("该用户没有家庭，无需上传家庭账单")
      } else{
          let famdebtArr = []
          for(let i=0;i<res.length;i++){
              let famNum = {famNum:res[i].famNum}
              let famdebt = Object.assign(famNum,perdebt)
              famdebtArr.push(famdebt)
          }
          await this.model('families_debt').addMany(famdebtArr)
      }
  }
  
  // 获取个人账单
  async personBillAction(){
      let data = this.post()
      let date = data.date
      let openid = data.openid
      let list = await this.model('person_bill').where({
          openid:openid,
          date:['like','%'+date+'%']
      }).order('date ASC').select()
      let perBill = []
      for(let i=0; i<list.length; i++){
          let classid = {icon_id:list[i].classid}
          let iconMsg = await this.model('class').where(classid).find()
          let obj = Object.assign(list[i],iconMsg)
          perBill.push(obj)
      }
      return this.json(perBill)
  }
  
  // 获取个人债务
  async personDebtsAction(){
      let data = this.post()
      let list = await this.model('person_debt').where(data).order('type ASC,date DESC').select()
      return this.json(list)
  }
  
  // 编辑个人账单
  async editPerBillAction(){
      let data = this.post()
      let id = {id:data.id}
      let openid = {openid:data.openid}
      
      // 更新内容
      let updateData = {
          classid:data.classid,
          billsub:data.billsub,
          spend:data.spend,
          date:data.date
      }
      await this.model('person_bill').where(id).update(updateData)
      // 判断是否有家庭
      let res = await this.model('families').where(openid).select()
      if (res.length == 0) {
          console.log("该用户没有家庭")
      } else{
          await this.model('families_bill').where(id).update(updateData)
      }
      
  }
  
  // 删除个人账单
  async delPerbillAction(){
      let data = this.post()
      console.log(data)
      await this.model('person_bill').where({
          id:data.id
      }).delete();
      // 判断是否有家庭
      let res = await this.model('families').where({
          openid:data.openid
      }).select()
      if (res.length == 0) {
          console.log("该用户没有家庭")
      } else{
          console.log("有家庭")
          await this.model('families_bill').where({
            id:data.id
          }).delete()
      }
  }
};
