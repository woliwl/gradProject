const Base = require('../base.js');
const URLEncoder = require('urlencode')

module.exports = class extends Base {
    
  // 模糊查询加多字段查询
  async indexAction() {
    let data = this.post()
    let {key} = data, name=URLEncoder.encode(key,"utf-8"),
    {openid} = data,famlist = [],perlist=[]
    // 图标
    let icons = await this.model('class').where({
        name:['like','%'+key+'%']
    }).select()
    // 找个人的家庭号
    let arr = await this.model('families_bill').where({openid:openid}).select()
    let num = []
    for(let i=0;i<arr.length;i++){
       num.push(arr[i].famNum)
    }
    // 去重
    function newArr(arr){
        return Array.from(new Set(arr))
    }
    // 取得的家庭号
    let famNum = newArr(num)
    
   if (icons.length != 0) {
      for(let i=0; i<icons.length; i++){
          perlist = await this.model('person_bill').where({
              openid:openid,
              _complex:{
                  nickName:['like','%'+name+'%'],
                  billsub:['like','%'+key+'%'],
                  classid:icons[i].icon_id,
                  _logic: 'OR'
              },
          }).select()
          
          famlist = await this.model('families_bill').where({
              famNum:['IN',famNum],
              _complex:{
                  nickName:['like','%'+name+'%'],
                  billsub:['like','%'+key+'%'],
                  classid:icons[i].icon_id,
                  _logic: 'OR'
              },
          }).select()
      }
   } else{
      perlist = await this.model('person_bill').where({
          openid:openid,
          _complex:{
              nickName:['like','%'+name+'%'],
              'date|billsub|spend':['like','%'+key+'%'],
              _logic: 'OR'
          },
       }).select() 
      famlist = await this.model('families_bill').where({
          famNum:['IN',famNum],
          _complex:{
              nickName:['like','%'+name+'%'],
              'date|billsub|spend':['like','%'+key+'%'],
              _logic: 'OR'
          },
          
      }).select() 
   }
   
   for(let i=0;i<perlist.length;i++){
       let classid = {icon_id:perlist[i].classid}
       let iconMsg = await this.model('class').where(classid).find()
       let obj = Object.assign(perlist[i],iconMsg)
   }
   for(let i=0;i<famlist.length;i++){
       let classid = {icon_id:famlist[i].classid}
       let iconMsg = await this.model('class').where(classid).find()
       let obj = Object.assign(famlist[i],iconMsg)
       famlist[i].famName = ''
   }
   
   let sumArr = []
   sumArr[0] = perlist
   sumArr[1] = famlist
   return this.json(sumArr)
  }
  
  // 通过家庭号获取家庭名称
  async getFamNameAction(){
      let data = this.post()
      let famName = await this.model('home').field('famName').where(data).find()
      return this.json(famName)
  }
};