<template>
    <view class="content">
        <!-- 1.债务页面里记录债务，页面主要显示个人债务
        2.利用抽屉组件显示家庭债务 -->
        <!-- 1.定义为我的债务
        2.填写我的债务选择分类（借入、借出）
        3.借入：从哪借入？设置还款日期，到期提醒，还款成功后存为历史记录（可删）
        4.借出：借给谁的？设置对方提出的还款日期，同上 -->
        
        <!-- 显示债务列表 -->
        <view class="listTitle">
            <view class="title1">
                共<text>{{debtsList.length}}</text>笔
            </view>
            <view class="title2">
               <view class="t2-t">
                    已还<text class="t_blue">{{refundNum}}</text>笔
               </view>
               <view class="t2-t">
                    未还<text class="t_red">{{debtsList.length==0?0:debtsList.length-refundNum}}</text>笔
               </view>
            </view>
        </view>
        <view class="debtList">
            <scroll-view scroll-y="true" style="height: 1200rpx;">
                <view class="listNotRefund" v-for="(item1,index1) in debtsList" :key="index1" 
                v-if="item1.status==0">
                    <view class="text">
                        <text>{{item1.date}}</text>向
                        <text>{{item1.who}}</text>{{item1.type==0?"借入":"借出"}}
                        <text>{{item1.spend}}</text>元
                    </view>
                    <view class="pbsoa">
                        <view class="notRefund" @click="refundFun(item1.status,item1.id)">
                            未还
                        </view>
                        <view class="icon" @click="delDebt(item1.id)">
                             <icon type="clear" size="20"/>
                        </view>
                    </view>
                    </block>
                </view>
                <view class="listContent" v-for="(item2,index2) in debtsList" :key="index2" 
                v-if="item2.status==1">
                    <view class="text">
                        <text>{{item2.date}}</text>向
                        <text>{{item2.who}}</text>{{item2.type==0?"借入":"借出"}}
                        <text>{{item2.spend}}</text>元
                    </view>
                    <view class="pbsoa">
                        <view class="checked" @click="refundFun(item2.status,item2.id)">
                            已还
                        </view>
                        <view class="icon" @click="delDebt(item2.id)">
                             <icon type="clear" size="20" />
                        </view>
                    </view>
                    </block>
                </view>
            </scroll-view>
        </view>
        
        <view class="selectBtn" @click="debts">债务</view>
        <!-- 弹出页面 -->
        <view class="create_popup">
            <uni-popup ref="select" type="center">
                <!-- 按钮 -->
                <view class="selectPanel">
                    <view class="se-pan-btn spbtn1" @click="debtIn">记录借入</view>
                    <view class="se-pan-btn spbtn2" @click="debtOut">记录借出</view>
                </view>
            </uni-popup>
            <!-- 表单 -->
            <uni-popup ref="debtMsg" type="center">
                <view class="panel">
                    <view class="form_box">
                        <form @submit="debtSubmit">
                            <view class="icon_select">
                                <view class="text colorRed" v-if="isDebtIn==true">借入时间</view>
                                <view class="text colorRed" v-else>借出时间</view>
                                <input class="colorRed" type="text" :value="nowDate" :disabled="true" name="date" />
                            </view>
                            <!-- 还款时间 -->
                            <view class="icon_select">
                                <view class="text">还款时间</view>
                                <picker mode="date" :value="refundDate" :start="refundDate" :end="endDate" @change="refundDateChange">
                                    <input type="text" :value="refundDate" :disabled="true" name="refundDate" />
                                </picker>
                            </view>
                            <!-- 借入对象 -->
                            <view class="icon_select">
                                <view class="text" v-if="isDebtIn==true">借入对象</view>
                                <view class="text" v-else>借出对象</view>
                                <input v-model="who" name="who" />
                            </view>
                            <!-- 费用 -->
                            <view class="icon_select">
                                <view class="text">费用</view>
                                <input v-model="spend" type="digit" name="spend" placeholder="0" />
                            </view>
                            <!-- 说明 -->
                            <view class="icon_select">
                                <view class="text">备注</view>
                                <input type="text" placeholder="补充债务细节~" v-model="debtSub" name="debtSub" />
                            </view>
                            <view class="btn_org">
                                <button form-type="submit">确定</button>
                            </view>
                        </form>
                    </view>
                </view>
            </uni-popup>
        </view>
    
    </view>
</template>

<script>
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
    import getTime from '../common/currentDate.js'
    import uniDrawer from "@/components/uni-drawer/uni-drawer.vue"
    export default {
        components: {
            uniPopup,
            uniDrawer
        },
        data() {
            const currentDate = getTime.dateDay({
                format: true
            })
            const loginMsg = wx.getStorageSync('login')
            return {
                isDebtIn: false,
                refundDate: currentDate,
                nowDate:currentDate,
                user:loginMsg.data,
                who: '',
                debtSub: '',
                spend: null,
                isChecked:false,
                debtsList:[],
                refundNum:0
            };
        },
        computed: {
            startDate() {
                return getTime.dateDay('start');
            },
            endDate() {
                return getTime.dateDay('end');
            }
        },
        methods: {
            debts() {
                this.$refs.select.open()
            },
            refundDateChange(e) {
                this.refundDate = e.target.value
            },
            // 债务面板
            debtIn() {
                this.isDebtIn = true
                this.$refs.debtMsg.open()
            },
            debtOut() {
                this.isDebtIn = false
                this.$refs.debtMsg.open()
            },
            debtSubmit(e) {
                console.log(e)
                if (e.detail.value.spend == 0 || e.detail.value.who == '') {
                    uni.showToast({
                        title: '请填写完整~',
                        icon: 'none'
                    })
                } else {
                    let type = {}
                    if (this.isDebtIn == true) {
                        type = {
                            type: 0
                        }
                    } else {
                        type = {
                            type: 1
                        }
                    }
                    this.debtRequest(e.detail.value, type)
                }
            },
            // 债务存函数
            debtRequest(data, type) {
                let param = Object.assign(this.user, data, type)
                this.$myRequest({
                    method: 'POST',
                    url: "/bill/person/createDebts",
                    data: param
                }).then(res => {
                    if (res.data == "OK") {
                        this.$refs.debtMsg.close()
                        // this.getPersonBill()
                        uni.showToast({
                            title: '成功！'
                        })
                        this.refundDate = this.currentDate
                        this.who = ''
                        this.spend = 0
                        this.debtSub = ''
                    }
                })
            },
            
            // 获取个人债务
            getPersonDebt(){
               let param = {openid:this.user.openid}
               this.$myRequest({
                   method:'POST',
                   url:"/bill/person/personDebts",
                   data:param
               }).then(res =>{
                   this.debtsList = res.data
                   res.data.forEach(el =>{
                       if(el.status==1){
                           this.refundNum +=1
                       }
                   })
               })
            },
            refundFun(status,id){
                let param = {status:status,id:id}
                if(status==0){
                    param.status = 1
                }else {
                    param.status = 0
                }
                this.$myRequest({
                    method:'POST',
                    url:"/bill/person/debtStatus",
                    data:param
                }).then(res =>{
                    this.getPersonDebt()
                })
            },
            delDebt(id){
                let param = {id:id}
                uni.showModal({
                    title:'',
                    content:'确认删除该记录吗？'
                }).then( res =>{
                    if(res[1].confirm == true){
                        this.$myRequest({
                            method:'POST',
                            url:"/bill/person/delDebt",
                            data:param
                        }).then(res =>{
                            this.getPersonDebt()
                        })
                    }
                })
            }
        },
        onLoad() {
            this.getPersonDebt()
        }
    };
</script>

<style lang="scss" src="./index.scss" scoped></style>
