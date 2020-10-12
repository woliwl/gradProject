<template>
    <view class="content">
        <!-- 日期选择器 -->
        <view class="uni-list">
            <view class="uni-list-cell">
                <view class="uni-list-cell-db">
                    <picker mode="date" :value="date" :start="startDate" :end="endDate" @change="bindDateChange">
                        <view class="uni-input">{{date}}</view>
                    </picker>
                </view>
            </view>
        </view>
        
        <!-- 创建账务-->
        <view class="createIn" @click="createIn">收</view>
        <view class="createOut" @click="createOut">支</view>
        
        <!-- 弹出页面 -->
        <view class="create_popup">
            <!-- 收 -->
            <uni-popup ref="createIn" type="center">
                <view class="panel">
                   <view class="form_box">
                        <form @submit="InSubmit">
                            <view class="time_input">
                                <view class="inputtit">时间</view>
                                <input type="text" :value="time" :disabled="true" name="date"/>
                            </view>
                           <!-- 图标选择 -->
                           <view class="icon_select">
                             <view class="text">类别选择</view>
                             <picker mode="selector" :range="iconsIn" v-model="index" 
                              :range-key="'name'" @change="iconsChange" name="arrid">
                                <view class="select_text">
                                    {{iconsIn[index].name}}
                                </view>
                              </picker>
                           </view>
                           <!-- 费用 -->
                           <view class="icon_select">
                               <view class="text">费用</view>
                               <input v-model="spend" type="digit" name="spend" placeholder="0"/>
                           </view>
                           <!-- 说明 -->
                           <view class="icon_select">
                               <view class="text">备注</view>
                               <input type="text" placeholder="补充账单细节~" :value="billsub" name="billsub"/>
                           </view>
                           <view class="createbtn">
                               <view class="wechatSI" @touchstart="touchStart()" @touchend="touchEnd()">
                                   <image v-if="recordState == false" class="wechatimg"
                                   src="../../static/icon/yy.png" mode="aspectFill"></image>
                                   <image v-else src="../../static/icon/yy_.png" class="wechatimg"
                                   mode="aspectFill"></image>
                               </view>
                               <button form-type="submit">确定</button>
                           </view>
                        </form>
                   </view>
                </view>
            </uni-popup>
            <!-- 支 -->
            <uni-popup ref="createOut" type="center">
                <view class="panel">
                   <view class="form_box">
                        <form @submit="OutSubmit">
                            <view class="time_input">
                                <view class="inputtit">时间</view>
                                <input type="text" :value="time" :disabled="true" name="date"/>
                            </view>
                           <!-- 图标选择 -->
                           <view class="icon_select">
                             <view class="text">类别选择</view>
                             <picker mode="selector" :range="iconsOut" v-model="index" 
                              :range-key="'name'" @change="iconsChange" name="arrid">
                                <view class="select_text_org">
                                    {{iconsOut[index].name}}
                                </view>
                              </picker>
                           </view>
                           <!-- 费用 -->
                           <view class="icon_select">
                               <view class="text">费用</view>
                               <input v-model="spend" type="digit" name="spend" placeholder="0"/>
                           </view>
                           <!-- 说明 -->
                           <view class="icon_select">
                               <view class="text">备注</view>
                               <input type="text" placeholder="补充账单细节~" v-model="billsub" name="billsub"/>
                           </view>
                           <view class="btn_org">
                               <button form-type="submit">确定</button>
                              </view>
                        </form>
                   </view>
                </view>
            </uni-popup>
            
            <!-- 编辑页面 -->
            <uni-popup ref="editbill" type="center">
                <view class="panel">
                   <view class="form_box">
                        <form @submit="editSubmit">
                            <view class="time_input">
                               <input type="text" value="时间(可选)" :disabled="true"/>
                                <picker mode="date" :value="editObj.date" :start="startDate" :end="endDate" 
                                @change="editdate">
                                    <input type="text" :value="editObj.date" :disabled="true" name="date"/>
                                </picker>
                                <picker mode="time" :value="editObj.time" start="01:00" end="24.00"
                                @change="edittime">
                                    <input type="text" :value="editObj.time" :disabled="true" name="time"/>
                                </picker>
                            </view>
                            <view style="display: none;">
                                <input type="text" :value="editObj.id" :disabled="true" name="id"/>
                                <input type="text" :value="editObj.quality" :disabled="true" name="quality"/>
                            </view>
                           <!-- 图标选择 -->
                           <view class="icon_select">
                             <view class="text">类别选择</view>
                             <picker mode="selector" :range="editObj.spend>0?iconsIn:iconsOut" v-model="index" 
                              :range-key="'name'" @change="iconsChange" name="arrid">
                                <view :class="editObj.spend>0?'select_text':'select_text_org'">
                                    {{editObj.spend>0?iconsIn[index].name:iconsOut[index].name}}
                                </view>
                              </picker>
                           </view>
                           <!-- 费用 -->
                           <view class="icon_select">
                               <view class="text">费用</view>
                               <input :value="editObj.quality==0?editObj.spend:0-editObj.spend" 
                               type="digit" name="spend" placeholder="0"/>
                           </view>
                           <!-- 说明 -->
                           <view class="icon_select">
                               <view class="text">备注</view>
                               <input type="text" placeholder="补充账单细节~" :value="editObj.billsub" name="billsub"/>
                           </view>
                           <view :class="editObj.spend>0?'btn':'btn_org'">
                               <button form-type="submit">确定</button>
                           </view>
                        </form>
                   </view>
                </view>
            </uni-popup>
        </view>
        
        <!-- 统计今日收支 -->
        <view class="countSum">
            <view class="inSum">
                <text>总收入:{{inSum}}</text>
            </view>
            <view class="outSum">
                <text>总支出:{{outSum}}</text>
            </view>
        </view>
        
        <!-- 获取账务列表 -->
        <view class="bill_list">
            <view class="steps" v-for="(item,i) in billdata" :key="i" >
                <view class="steps-status">
                    <view class="status-dot">{{item.date.substring(item.date.indexOf(' ')+1,item.date.length)}}</view>
                    <view class="status-lint"></view>
                </view>
                <view class="steps-content">
                   <scroll-view :scroll-top="scrollTop" scroll-y="true" class="scroll-Y" 
                   style="height: 210rpx;">
                        <view class="content" v-for="(bill,j) in item.bill" :key="j"
                        :class="bill.spend > 0 ? 'borin' : 'borout'" 
                        @click="editbill(bill,item.date)">
                            <view class="icons" 
                            :class="bill.spend > 0 ? 'colorin' : 'colorout'">
                                <text class="iconfont" :class="bill.font_class"></text>
                                {{bill.name}}
                            </view>
                            <view class="del" @click.stop="deletebill(bill.id)">
                                <uni-icons type="closeempty" size="20" color='#ffb89b'></uni-icons>
                            </view>
                            <view class="spend">
                                <text>{{bill.spend>0?'收入:':'支出:'}}</text>
                                {{bill.spend>0?bill.spend:0-bill.spend}}
                            </view>
                            <view class="sub" v-if="bill.billsub != ''">
                                备注:{{bill.billsub}}
                            </view>
                        </view>
                    </scroll-view>
                </view>
            </view>
        </view>
    </view>
</template>

<script>
    import uniIcons from "@/components/uni-icons/uni-icons.vue"
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
    import getTime from '../../common/currentDate.js'
    var plugin = requirePlugin("WechatSI")
    var manager = plugin.getRecordRecognitionManager()
    
export default {
    
    components: {uniIcons,uniPopup},
    data() {
        const currentDate = getTime.dateDay({
           format: true
        })
        const currentTime = getTime.now()
        const loginMsg = wx.getStorageSync('login')
        return {
            date: currentDate,
            time:currentTime,
            iconfont:'iconfont',
            index:0,
            iconsIn:[],
            iconsOut:[],
            spend:null,
            billsub:'',
            user:loginMsg.data,
            scrollTop: 0,
            billdata:[],
            inSum:0,
            outSum:0,
            inImg:"../../../static/icon/sj_.png",
            outImg:"../../../static/icon/sj.png",
            editObj:{},
            
            // 语音转文本
            recordState:false
        };
    },
    computed:{
       startDate() {
           return getTime.dateDay('start');
       },
       endDate() {
           return getTime.dateDay('end');
       } 
    },
    methods:{      
       bindDateChange(e){
           this.date = e.target.value
           this.inSum = 0
           this.outSum = 0
           this.getPersonBill()
       },
       editdate(e){
         this.editObj.date = e.target.value  
       },
       edittime(e){
         this.editObj.time = e.target.value  
       },
       // 开始录音
       touchStart(e){
           this.recordState = true
           uni.showToast({
              title:"正在说话...",
              icon:"none"
           })
           manager.start({  
              lang: "zh_CN"  
           })
       },
       // 结束录音
       touchEnd(){
           this.recordState = false
           manager.stop(); 
       },
       // 识别语音 初始化
       initRecord(){
           manager.onRecognize(res =>{
               console.log(res)
           })
           // 正常开始录音
           manager.onStart(res =>{
               console.log("成功开始语音识别",res)
           })
           // 识别错误事件
           manager.onError(err =>{
               console.log("err msg" ,res)
           })
           // 识别结束
           manager.onStop(res =>{
               console.log('-----结束录音-----')
               console.log('录音临时文件地址 -->' + res.tempFilePath); 
               console.log('录音总时长 -->' + res.duration + 'ms'); 
               console.log('文件大小 --> ' + res.fileSize + 'B');
               console.log('语音内容 --> ' + res.result);
               if(res.result == ''){
                   uni.showToast({
                       title:"听不清楚嗷，请重新说一遍嘛！",
                       icon:"none"
                   })
               }
               let text = this.billsub + res.result
               this.billdata = text
           })
       },
       
       // 记账面板打开
       createIn(){
           this.$refs.createIn.open()
           this.initRecord()
           // 获取收入图标
           this.$myRequest({
               method:'GET',
               url:"/bill/person/getIconsIn"
           }).then(res =>{
               this.iconsIn = res.data
           })
       },
       createOut(){
           this.$refs.createOut.open()
           // 获取支出图标
           this.$myRequest({
               method:'GET',
               url:"/bill/person/getIconsOut"
           }).then(res =>{
               this.iconsOut = res.data
           })
       },
       iconsChange(e){
           this.index = e.target.value
       },
       // 收
       InSubmit(e){
           // 组合要传递的参数
           if(e.detail.value.spend == 0){
               uni.showToast({
                   title:'请填写费用~',
                   icon:'none'
               })
           }else{
               let index = e.detail.value.arrid
               let classid = {classid:this.iconsIn[index].icon_id}
               let formdata = {
                   date:e.detail.value.date,
                   billsub:e.detail.value.billsub,
                   spend:e.detail.value.spend
               }
               let param = Object.assign(this.user,formdata,classid)
               console.log(param)
               this.$myRequest({
                   method:'POST',
                   url:"/bill/person/createBill",
                   data:param
               }).then(res =>{
                   if(res.data == "OK"){
                      this.$refs.createIn.close()
                      this.getPersonBill()
                      uni.showToast({
                          title:'成功！'
                      }) 
                      this.index = 0
                      this.spend = null
                      this.billsub = ''
                      this.inSum = 0
                      this.outSum = 0
                   }
               })
           }         
       },
       // 支
       OutSubmit(e){
           // 组合要传递的参数
           if(e.detail.value.spend == 0){
               uni.showToast({
                   title:'请填写费用~',
                   icon:'none'
               })
           }else{
               let index = e.detail.value.arrid
               let classid = {classid:this.iconsOut[index].icon_id}
               let formdata = {
                   date:e.detail.value.date,
                   billsub:e.detail.value.billsub,
                   spend:`-`+e.detail.value.spend
               }
               let param = Object.assign(this.user,formdata,classid)
               this.$myRequest({
                   method:'POST',
                   url:"/bill/person/createBill",
                   data:param
               }).then(res =>{
                   if(res.data == "OK"){
                      this.$refs.createOut.close()
                      this.getPersonBill()
                      uni.showToast({
                          title:'成功！'
                      }) 
                      this.index = 0
                      this.spend = null
                      this.billsub = ''
                      this.inSum = 0
                      this.outSum = 0
                   }
               })
           }
       },
    
       // 个人列表获取
       getPersonBill(){
           let openid = {openid:this.user.openid}
           let date = {date:this.date}
           let param = Object.assign(openid,date)
           this.$myRequest({
               method:'POST',
               url:"/bill/person/personBill",
               data:param
           }).then(res =>{
               // 总数据
               let {data} = res
               // 原数据转目标数据规则
               let oldData = []
               for (let i=0;i<data.length;i++) {
                   let oldObj = {
                       date:data[i].date,
                       bill:[]
                   }
                   let billObj = {
                       avatarUrl:data[i].avatarUrl,
                       nickName:data[i].nickName,
                       font_class:data[i].font_class,
                       name:data[i].name,
                       id:data[i].id,
                       spend:data[i].spend,
                       billsub:data[i].billsub
                   }
                   oldObj.bill.push(billObj)
                   oldData.push(oldObj)
                   
                   // 计算收支
                   if(data[i].spend > 0){
                       this.inSum += parseFloat(data[i].spend)
                   }else{
                       this.outSum -= parseFloat(data[i].spend)
                   }
               }
               // 去重合并
               let newData = []  //目标数据
               let newObj = {}
               oldData.forEach((el,i) =>{
                   if(!newObj[el.date]){
                       newData.push(el);
                       newObj[el.date] = true
                   }else{
                       newData.forEach(el =>{
                           if(el.date === oldData[i].date){
                               el.bill = [...el.bill,...oldData[i].bill]
                           }
                       })
                   }
               })
               this.billdata = newData   
           })
       },
    
      // 编辑
      editbill(bill,date){
         let object = {
              spend:bill.spend,
              id:bill.id,
              billsub:bill.billsub,
              date:date.substring(0,date.indexOf(' ')),
              time:date.substring(date.indexOf(' '))
          }
          if(bill.spend > 0){
              this.$myRequest({
                  method:'GET',
                  url:"/bill/person/getIconsIn"
              }).then(res =>{
                  let iconsIn = res.data
                  for (let i=0;i<iconsIn.length;i++) {
                      if(iconsIn[i].name == bill.name)
                      this.index = i
                      bill['quality'] = iconsIn[i].quality
                  }
                  let quality = {quality:bill.quality}
                  this.editObj = Object.assign(object,quality)
                  this.iconsIn = iconsIn
              })
          }else{
             this.$myRequest({
                 method:'GET',
                 url:"/bill/person/getIconsOut"
             }).then(res =>{
                 let iconsOut = res.data
                 for (let i=0;i<iconsOut.length;i++) {
                     if(iconsOut[i].name == bill.name)
                     this.index = i
                     bill['quality'] = iconsOut[i].quality
                 }
                 let quality = {quality:bill.quality}
                 this.editObj = Object.assign(object,quality)
                 this.iconsOut = iconsOut
             }) 
          }
          this.$refs.editbill.open()
      },
      editSubmit(e){
          let {value} = e.detail
          let index = value.arrid
          let formdata = {
              date:value.date+' '+value.time,
              billsub:value.billsub,
              id:value.id
          } 
          let param = {}
          if(value.quality == 0){
              let classid = {classid:this.iconsIn[index].icon_id}
              let spend = {spend:value.spend}
              param = Object.assign(this.user,formdata,classid,spend)
          }else{
              let classid = {classid:this.iconsOut[index].icon_id}
              let spend = {spend:0-value.spend}
              param = Object.assign(this.user,formdata,classid,spend)
          }
          
          this.$myRequest({
              method:'POST',
              url:"/bill/person/editPerBill",
              data:param
          }).then(res =>{
              this.$refs.editbill.close()
              this.getPersonBill()
              uni.showToast({
                  title:'修改成功！'
              }) 
              this.index = 0
              this.spend = null
              this.billsub = ''
              this.inSum = 0
              this.outSum = 0
          })
      },
      
      // 删除
      deletebill(id){
          uni.showModal({
              title: '注意',
              content: '数据无法恢复！确定删除吗？'
          }).then(res =>{
              if(res[1].confirm == true){
                  let param = {
                      id:id,
                      openid:this.user.openid
                   }
                  this.$myRequest({
                      method:'POST',
                      url:"/bill/person/delPerbill",
                      data:param
                  }).then(res =>{
                      uni.showToast({
                          title: '删除成功'
                      });
                      this.getPersonBill()
                      this.inSum = 0
                      this.outSum = 0
                  })
              }else{
                  uni.showToast({
                      title: '取消操作',
                      icon:'none'
                  })
              }
          })
      }
      
      
    },
    
    mounted() {
       this.getPersonBill()
       this.initRecord()
    }
};
</script>

<style lang="scss" src="./main.scss" scoped></style>
