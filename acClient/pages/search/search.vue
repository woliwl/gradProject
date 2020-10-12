<template>
	<view class="concent">
        <view class="form_box">
            <form @submit="keySearch">
                <input class="uni-input" confirm-type="search" :value="keywords" 
                placeholder="关键字搜索账单..." name="keywords"/>
                <button form-type="submit" type="default" class="btn">
                    <uni-icons type="search" size="30" color="#fff"></uni-icons>
                </button>
            </form>
        </view>
        
		<!-- 搜索结果 -->
        <view class="searchRes">
            <view class="perlist" v-for="(item,i) in perlist" :key="i"
            @click="editbill(item,item.date)">
                <view class="icons"
                :class="item.spend > 0 ? 'colorin' : 'colorout'">
                    <text class="iconfont" :class="item.font_class"></text>
                    {{item.name}}
                </view>
                <view class="date"
                :class="item.spend > 0 ? 'colorin' : 'colorout'">
                    时间:{{item.date}}
                </view>
                <view class="spend">
                    <text>{{item.spend>0?'收入:':'支出:'}}</text>
                    {{item.spend>0?item.spend:0-item.spend}}
                </view>
                <view class="sub" v-if="item.billsub != ''">
                    备注:{{item.billsub}}
                </view>
                <view class="usermsg"  @click.stop="deletebill(item.id)">
                    <uni-icons type="closeempty" size="20" color='#ffb89b'></uni-icons>
                </view>
            </view>
            <view class="famlist" v-for="(item,j) in famlist" :key="j">
                <view class="sfamName">
                    {{item.famName}}
                </view>
                <view class="icons"
                :class="item.spend > 0 ? 'colorin' : 'colorout'">
                    <text class="iconfont" :class="item.font_class"></text>
                    {{item.name}}
                </view>
                <view class="date"
                :class="item.spend > 0 ? 'colorin' : 'colorout'">
                    时间:{{item.date}}
                </view>
                <view class="spend">
                    <text>{{item.spend>0?'收入:':'支出:'}}</text>
                    {{item.spend>0?item.spend:0-item.spend}}
                </view>
                <view class="sub" v-if="item.billsub != ''">
                    备注:{{item.billsub}}
                </view>
                <view class="usermsg">
                    <text class="text">{{decodeURIComponent(item.nickName)}}</text>
                    <image :src="item.avatarUrl" class="img" mode="aspectFill"></image>
                </view>
            </view>
        </view>
        
        <!-- 弹出编辑页面 -->
        <view class="create_popup">
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
        
	</view>
</template>

<script>
    import uniIcons from "@/components/uni-icons/uni-icons.vue"
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
    import getTime from '../../common/currentDate.js'
	export default {
        components: {uniIcons},
		data() {
            const currentDate = getTime.dateDay({
               format: true
            })
            const currentTime = getTime.now()
            const loginMsg = wx.getStorageSync('login')
			return {
				keywords:'',
                user:loginMsg.data,
                date: currentDate,
                time:currentTime,
                perlist:[],
                famlist:[],
                editObj:{},
                iconsIn:[],
                iconsOut:[],
                index:0,
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
            editdate(e){
              this.editObj.date = e.target.value  
            },
            edittime(e){
              this.editObj.time = e.target.value  
            },
            iconsChange(e){
                this.index = e.target.value
            },
            keySearch(e){
                uni.showLoading({
                    title: '正在搜索中嗷！'
                });
                wx.setStorageSync('key',e)
                let key = {key:e.detail.value.keywords}
                let openid = {openid:this.user.openid}
                let param = Object.assign(key,openid)
                this.$myRequest({
                    method:'POST',
                    url:"/bill/search/index",
                    data:param
                }).then(res =>{
                    if(res.data[0].length == 0 && res.data[1].length == 0){
                        uni.showToast({
                            title:"没有数据",
                            icon:"none"
                        })
                    }
                    let perlist = res.data[0]
                    let famlist = res.data[1]
                    famlist.forEach(el =>{
                        this.$myRequest({
                            method:'POST',
                            url:"/bill/search/getFamName",
                            data:{famNum:el.famNum}
                        }).then(res =>{
                            el.famName = res.data.famName
                        })
                    })
                    uni.hideLoading();
                    this.perlist = perlist
                    this.famlist = famlist
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
                            let keyword = wx.getStorageSync('key')
                            this.keySearch(keyword)
                        })
                    }else{
                        uni.showToast({
                            title: '已取消',
                            icon:'none'
                        })
                    }
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
                    date:value.date+value.time,
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
                    let keyword = wx.getStorageSync('key')
                    this.keySearch(keyword)
                    uni.showToast({
                        title:'修改成功！'
                    }) 
                    this.index = 0
                })
            },
        }
	}
</script>

<style lang="scss" src="./search.scss"></style>
<style lang="scss" src="../main/main.scss" scoped></style>
