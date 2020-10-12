<template>
	<view class="content">
        <!-- 创建/加入 按钮 -->
        <view class="famBtn">
            <uni-fab
               :pattern="pattern"
               :content="content"
               :horizontal="horizontal"
               :vertical="vertical"
               :direction="direction"
               @trigger="trigger"
            ></uni-fab>

        </view>
        <!-- 存在 -->
        <view class="family" v-if="famlist.length > 0"
        :style="{height:height*2-30 + 'rpx',width:width*2 + 'rpx'}">
            <view class="list" v-for="(item,index) in famlist" :key="index">
                <view class="tag" v-if="item.openid==hz_openid">
                    <image src="../../static/icon/hg.png" mode="aspectFill" class="img"></image>
                </view>
                <view class="left" @click="showFam(item.famNum,item.openid)">
                    <view class="text">
                        <view class="famname">{{item.famName}}</view>
                        <view class="num" @click.stop="copyNum(item.famNum)">{{item.famNum}}</view>
                        <view class="nick">
                            家  主：{{decodeURIComponent(item.nickName)}}
                            <image :src="item.avatarUrl" mode="aspectFill" class="img"></image>
                        </view>
                        <view class="nick">
                            创建时间：{{item.date.slice(0, 10)}}
                        </view>
                    </view>
                </view>
                <view class="right" @click="delFam(item.openid,item.famNum)" v-if="item.openid==hz_openid">
                   ×
                </view>
            </view>
        </view>
        <!-- 不存在 -->
        <view class="not" v-else>
            <image src="../../static/icon/not.png" class="not_img" mode="aspectFill"></image>
            还没有家庭~
        </view>
        
        <!-- 弹窗 -->
        <view class="alert">
            <!-- 创建家庭 -->
            <uni-popup ref="creatFam" type="center">
                <view class="dialog dialog_2">
                    <!-- 确认创建后返回的家庭号 -->
                    <view class="isUploadbox" v-if="isUpload == true">
                        <view class="title">是否同意上传你的历史账单至家庭<text> {{famName}} </text>？</view>
                        <view class="text">* 上传个人历史账单只在创建/加入家庭时，如果没有上传则家庭账单内容只显示创建/加入该家庭后所记录的账单内容</view>
                        <view class="btnbox">
                        <button @click="notUpload" class="btn" >不同意</button>
                        <button @click="yesUpload(famNum)" class="btn" >同意</button>
                        </view>
                    </view>
                    <view class="famNum" v-else-if="numShow == true">
                        <text class="fam">记住你的家庭号</text><br/><br/>
                        <text class="num">{{famNum}}</text>
                        <button @click="copyFamNum" class="btn1">复制</button>
                    </view>
                    <view class="formbox" v-else>
                        <form @submit="creatSubmit">
                            <view class="input">
                                <text class="name">{{tip1}}</text>
                                <input class="uni-input" name="input"/>
                            </view>
                            
                            <button form-type="submit" class="btn2">提交</button>
                        </form>
                    </view>
                </view>
            </uni-popup>
            
            <!-- 加入家庭 -->
            <uni-popup ref="joinFam" type="center">
                <view class="dialog dialog_2">
                    <view class="famNum" v-if="joinShow == true">
                        <text class="fam">确认加入</text><br/><br/>
                        <text class="num">{{famName}}</text>
                        <button @click="joinFam(joinNum,famName)" class="btn1">确认</button>
                    </view>
                    <view class="isUploadbox" v-else-if="isUpload == true">
                        <view class="title">是否同意上传你的历史账单至家庭<text> {{famName}} </text>？</view>
                        <view class="text">* 上传个人历史账单只在创建/加入家庭时，如果没有上传则家庭账单内容只显示创建/加入该家庭后所记录的账单内容</view>
                        <view class="btnbox">
                        <button @click="notUpload" class="btn" >不同意</button>
                        <button @click="yesUpload(joinNum.famNum)" class="btn" >同意</button>
                        </view>
                    </view>
                    <view class="formbox" v-else>
                        <form @submit="findSubmit">
                            <view class="input">
                                <text class="name">{{tip2}}</text>
                                <input class="uni-input" name="input"/>
                            </view>
                            <button form-type="submit" class="btn2" size="default" >提交</button>
                        </form>
                    </view>
                </view>
            </uni-popup>            
        </view>
	</view>
</template>

<script>
    import uniPopup from '@/components/uni-popup/uni-popup.vue';
    import uniFab from '@/components/uni-fab/uni-fab.vue';
	export default {
        components: {
          uniPopup,
          uniFab
        },
		data() {
			return {
				famlist:[],
                relat:'',
                width:null,
                height:null,
                
                horizontal: 'left',
                vertical: 'bottom',
                direction: 'vertical',
                pattern: {
                   color: '#8a8a8a',
                   backgroundColor: '#fff',
                   selectedColor: '#FB9B5E',
                   buttonColor:"#FB9B5E",
                },
                content:[
                    {
                       text: '创建',
                       active: false
                    },
                    {
                       text: '加入',
                       active: false
                    }
                ],
                
                tip1:'输入家庭名称(16个字符以内)',
                tip2:'输入家庭号',
                famNum:'',
                famName:'',
                numShow:false,
                isUpload:false,
                joinShow:false,
                joinNum:'',
                
                hz_openid:''
			};
		},
        methods:{
            // 创建加入按钮
            trigger(e) {
                let other = this.content.map((d, i) => {
                   d.active = i== e.index
                })
                if(e.index == 0){
                   this.$refs.creatFam.open() 
                }else{
                   this.$refs.joinFam.open()
                }
            },
            
            // 表单事件
            // 创建
            creatSubmit(e){
               let loginMsg = wx.getStorageSync('login')
               let userMsg = loginMsg.data
               let famName = {famName:e.detail.value.input}
               this.famName = e.detail.value.input
               if(!famName.famName){
                   this.tip1="输入框不能为空哦~"
               }else{
                   let date = {date:new Date().toISOString()} 
                   let datas = Object.assign(userMsg,famName,date)
                   // this.isUpload = true
                   this.$myRequest({
                       method:'POST',
                       url:"/families/families/createFam",
                       data:datas
                   }).then(res =>{
                       this.famNum = res.data.famNum
                       this.isUpload = true
                       this.getFam()
                       uni.showToast({
                           title:'创建成功'
                       })
                   })
               }
            },
            // 同意上传
            yesUpload(num){
                let loginMsg = wx.getStorageSync('login')
                let openid = {openid:loginMsg.data.openid}
                let famNum = {famNum:num}
                let datas = Object.assign(openid,famNum)
                this.$myRequest({
                    method:'POST',
                    url:"/families/families/isUpload",
                    data:datas
                }).then(res =>{
                    this.numShow = true
                    this.isUpload = false
                    if(res.data == 'yes'){
                        this.$refs.joinFam.close()
                        console.log(datas)
                        uni.showToast({
                            title:'上传成功'
                        })
                    }else{
                        console.log(res.data)
                        this.$refs.joinFam.close()
                        uni.showToast({
                            title:'上传失败，请联系客服',
                            icon:'none'
                        })
                    }
                })
            },
            //不同意上传
            notUpload(){
                this.numShow = true
                this.isUpload = false
                this.$refs.joinFam.close()
                uni.showToast({
                    title:'取消操作',
                    icon:'none'
                })
            },
            
            // 查询
            findSubmit(e){
               let famNum = {famNum:e.detail.value.input}
               if(!famNum.famNum){
                   this.tip2="输入框不能为空哦~"
               }else{
                  this.$myRequest({
                      method:'POST',
                      url:"/families/families/findFam",
                      data:famNum
                  }).then(res =>{
                      if(!res.data){
                          this.tip2 = "请输入正确的家庭号~"
                      }else{
                          this.famName = res.data
                          this.joinNum = famNum
                          this.joinShow = true
                      }
                  }) 
               }
            },
            
            // 加入
            joinFam(nu,na){
              let loginMsg = wx.getStorageSync('login')
              
              let userMsg = loginMsg.data
              let famNum = {famNum:nu.famNum}
              let famName = {famName:na}
              let date = {date:new Date().toISOString()}
              let datas = Object.assign(userMsg,famName,famNum,date)
              
              this.$myRequest({
                  method:'POST',
                  url:"/families/families/joinFam",
                  data:datas
              }).then(res =>{
                  if(res.data == "exist"){
                      uni.showToast({
                        title: '你早就加入这个家庭啦~',
                        icon:'none',
                      })
                      this.joinShow = false
                  }else{
                      this.getFam()
                      uni.showToast({
                          title:'加入成功'
                      })
                      this.joinShow = false
                      this.isUpload = true
                  }
              })
            },
            
            // 复制家庭号
            copyFamNum(){
                wx.setClipboardData({
                	data: this.famNum,
                	success: function(res) {
                		wx.getClipboardData({
                			success: function(res) {
                				wx.showToast({
                					title: '已复制到剪贴板'
                				});
                			}
                		});
                	}
                });
                this.numShow = false
                this.$refs.creatFam.close() 
            },
            copyNum(num){
               wx.setClipboardData({
               	data: num,
               	success: function(res) {
               		wx.getClipboardData({
               			success: function(res) {
               				wx.showToast({
               					title: '已复制到剪贴板'
               				});
               			}
               		});
               	}
               }); 
            },
            
            // 获取家庭列表
            getFam(){
              let loginMsg = wx.getStorageSync('login')
              // console.log(loginMsg)
              this.$myRequest({
                  method:'POST',
                  url:"/families/families/index",
                  data:{
                      openid:loginMsg.data.openid
                  }
              }).then(res =>{
                  if(res.data == 'not'){
                      console.log(res.data)
                  }else{
                      this.famlist = res.data
                  }
              })
            },
            
            // 删除家庭
            delFam(id,num){
               uni.showModal({
                   title: '注意',
                   content: '相应的家庭账单也会删除，并且数据无法恢复！确定删除吗？'
               }).then(res =>{
                   if(res[1].confirm == true){
                       this.$myRequest({
                           method:'POST',
                           url:"/families/families/delFam",
                           data:{
                               famNum:num
                           }
                       }).then(res =>{
                           if(res.data == 'success'){
                               this.getFam()
                               uni.showToast({
                                   title: '删除成功',
                               })
                           }else{
                               console.log(res.data)
                               uni.showToast({
                                   title:'删除失败',
                                   icon:'none'
                               })
                           }
                       })
                       
                   }else{
                        uni.showToast({
                            title: '取消操作',
                            icon:'none'
                        })  
                   }
               })
            },
            
            // 查看家人
            showFam(num,id){
                uni.navigateTo({
                    url:'../families/families?famNum='+num+'&id='+id
                })
            }
        },
        
        onLoad() {
            const { windowWidth, windowHeight } = uni.getSystemInfoSync();
            this.width = windowWidth
            this.height = windowHeight
            
            let loginMsg = wx.getStorageSync('login')
            this.hz_openid = loginMsg.data.openid
            
            this.getFam()
        }
	}
</script>

<style lang="scss" src="./home.scss">

</style>
