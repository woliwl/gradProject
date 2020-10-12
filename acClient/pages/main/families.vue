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
            <view class="steps" v-for="(item,i) in billdata" :key="i">
                <view class="steps-status">
                    <view class="status-dot">{{item.date.substring(item.date.indexOf(' ')+1,item.date.length)}}</view>
                    <view class="status-lint"></view>
                </view>
                <view class="steps-content">
                   <scroll-view :scroll-top="scrollTop" scroll-y="true" class="scroll-Y" 
                   style="height: 200rpx;">
                        <view class="content" v-for="(bill,j) in item.bill" :key="j"
                          :class="bill.spend > 0 ? 'borin' : 'borout'" >
                            <view class="icons" 
                            :class="bill.spend > 0 ? 'colorin' : 'colorout'">
                                <text class="iconfont" :class="bill.font_class"></text>
                                {{bill.name}}
                            </view>
                            <view class="spend">
                                <text>{{bill.spend>0?'收入:':'支出:'}}</text>
                                 {{bill.spend>0?bill.spend:0-bill.spend}}
                            </view>
                            <view class="sub" v-if="bill.billsub != ''">
                                备注:{{bill.billsub}}
                            </view>
                            
                            <view class="usermsg">
                                <text class="text">{{decodeURIComponent(bill.nickName)}}</text>
                                <image :src="bill.avatarUrl" class="img" mode="aspectFill"></image>
                            </view>
                        </view>
                    </scroll-view>
                </view>
            </view>
        </view>
        
       
       <!-- 家庭列表面板 --> 
        <view class="btn">
            <picker mode="selector" :range="famlist" v-model="index"
             :range-key="'famName'" @change="famlistChange">
               <view class="select_text">
                   {{famlist[index].famName}}
               </view>
             </picker>
        </view>
    </view>
</template>

<script>
   import uniIcons from "@/components/uni-icons/uni-icons.vue"
   import getTime from '../../common/currentDate.js'
export default {
    components: {
        uniIcons
    },
    data() {
        const currentDate = getTime.dateDay({
           format: true
        })
        const currentTime = getTime.now()
        const loginMsg = wx.getStorageSync('login')
        return {
            famMenwShow:false,
            user:loginMsg.data,
            famlist:[],
            index:0,
            famNum:'',
            famName:'',
            date: currentDate,
            time:currentTime,
            user:loginMsg.data,
            scrollTop: 0,
            billdata:[],
            inSum:0,
            outSum:0,
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
        famlistChange(e){
            this.index = e.target.value
            this.famNum = this.famlist[this.index].famNum
            this.famName = this.famlist[this.index].famName
            this.inSum = 0
            this.outSum = 0
            this.getFamiliesBill()
        },
        getfamlist(){
           let openid = {openid:this.user.openid}
           this.$myRequest({
               method:'POST',
               url:"/families/families/index",
               data:openid
           }).then(res =>{
              this.famlist = res.data
              if(this.famlist.length != 0){
                  this.famNum = this.famlist[0].famNum
                  this.famName = this.famlist[0].famName
              }
              this.getFamiliesBill()
           }) 
        },
        
        bindDateChange(e){
            this.date = e.target.value
            this.inSum = 0
            this.outSum = 0
            this.getFamiliesBill()
        },
        getFamiliesBill(){
            let openid = {openid:this.user.openid}
            let date = {date:this.date}
            let famNum = {famNum:this.famNum}
            let param = Object.assign(openid,date,famNum)
            this.$myRequest({
                method:'POST',
                url:"/bill/families/familiesBill",
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
        
    },
    mounted() {
        this.getfamlist()
        this.getFamiliesBill()
    }
    
};
</script>

<style lang="scss" src="./main.scss" scoped></style>
