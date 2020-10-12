const Base = require('../base.js');

// 显示页面
module.exports = class extends Base {
  async familiesBillAction() {
     let data = this.post()
     let date = data.date
     let list = await this.model('families_bill').where({
         date:['like','%'+date+'%'],
         famNum:data.famNum
     }).order('date ASC').select()
     let famBill = []
     for(let i=0; i<list.length; i++){
         let classid = {icon_id:list[i].classid}
         let iconMsg = await this.model('class').where(classid).find()
         let obj = Object.assign(list[i],iconMsg)
         famBill.push(obj)
     }
     return this.json(famBill)
  }
  
};
