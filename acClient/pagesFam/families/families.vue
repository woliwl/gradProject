<template>
	<view>
        <!-- 1.自己的家庭-删除好友功能
             2.加入的家庭-退出家庭功能
         -->
		<view class="families" :style="{height:height*2-30 + 'rpx',width:width*2 + 'rpx'}">
		    <view class="list" v-for="(item,index) in famlist" :key="index">
		        <view class="main">
                    <view class="tag" v-if="item.openid==host_id">
                        <image src="../../static/icon/hg.png" mode="aspectFill" class="tagimg"></image>
                    </view>
                    <image class="img" :src="item.avatarUrl" mode="aspectFill"></image>
                    <view class="nick">{{decodeURIComponent(item.nickName)}}</view>
                </view>
                <view class="del" @click="outHome(item.openid,host_num)" 
                v-if="item.openid!=host_id && myid==host_id">
                    ×
                </view>
		    </view>
		</view>   
        <view class="out" v-if="myid != host_id && famlist.length!=0" @click="outHome(myid,host_num)">
            <text>退出家庭</text>
        </view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				host_num:'',
                host_id:'',
                myid:'',
                famlist:[]
			};
		},
        
        methods:{
          del(){
             this.$refs.del.open() 
          },
          
          // 获取家人列表
          getFamlist(){
              //测试
             let num = {famNum:this.host_num}
             this.$myRequest({
                 method:'POST',
                 url:"/families/families/getFams",
                 data:num
             }).then(res =>{
                 console.log(res)
                 this.famlist = res.data
             })
          },
                  
          // 退出家庭
          outHome(id,num){
              let openid = {openid:id},
                  famNum = {famNum:num},
                  datas = Object.assign(openid,famNum)
              uni.showModal({
                  title:'注意',
                  content:'退出/删除后数据无法恢复！确认要这样操作吗？'
              }).then(e =>{
                  if(e[1].confirm == true){
                      this.$myRequest({
                          method:'POST',
                          url:"/families/families/outHome",
                          data:datas
                      }).then(res =>{
                          uni.redirectTo({
                              url:'../home/home'
                          })
                          console.log(res.data)
                          uni.showToast({
                              title: '操作成功',
                          })
                      })
                  }else{
                      uni.showToast({
                          title:'取消操作',
                          icon:'none'
                      })
                  }
              })
          }
        },
        
        onLoad(option) {
           const { windowWidth, windowHeight } = uni.getSystemInfoSync();
           this.width = windowWidth
           this.height = windowHeight
           
           let loginMsg = wx.getStorageSync('login')
           this.myid = loginMsg.data.openid
           this.host_num = option.famNum
           this.host_id = option.id
           this.getFamlist()
        }
	}
</script>

<style lang="scss" src="./families.scss"></style>
