<template>
	<view class="container">
		<view class="logo">
            <image class="img" src="../../static/icon/logo_.png" mode="aspectFill">
            </image>
        </view>
        <view class="btn">
            <button type="default" class="but" @click="open">开始使用</button>
            <uni-popup ref="popup" type="center">
                <view class="dialog">
                    <image class="icon" src="../../static/icon/logo_.png" mode="aspectFill">
                    <text class="text">申请获得您的公开信息（昵称、头像等）</text>
                    <button class="btn" type="default" open-type="getUserInfo" 
                    @getuserinfo="wxGetUserInfo">授权登录</button>
                </view>
            </uni-popup>
        </view>
	</view>
</template>

<script>
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
	export default {
        components: {
          uniPopup
        },
		data() {
			return {
				loginMsg:'',
                width:null,
                height:null
			}
		},  
		methods: {
            open(){
              // 判断是否授权
              uni.getSetting({
                  success: (res) => {
                     if (!res.authSetting['scope.userInfo']) {
                          // 用户未授权
                          this.$refs.popup.open()
                          console.log("当前未授权");
                     } else {
                          //用户已经授权
                          uni.getUserInfo({
                             provider: 'weixin' 
                          }).then(info =>{
                              this.wxGetUserInfo()
                              wx.setStorageSync('userMsg',info)
                              console.log(uni.getStorageInfoSync('login'))
                          })
                          uni.switchTab({
                              url: '../me/me'
                          });
                          console.log("当前已授权");
                     }
                  }
              })
            },
            // 授权登录
            wxGetUserInfo(){
              uni.login({
                     provider: 'weixin'
              }).then(loginRes =>{
                  uni.getUserInfo({
                      provider: 'weixin'
                  }).then(info =>{
                      wx.setStorageSync('userMsg',info)
                      // 发送请求
                      this.$myRequest({
                          method:'POST',
                          url:"/user/login/index",
                          data:{
                              code:loginRes[1].code,
                              userMsg:info[1].rawData
                          }
                      }).then(res =>{
                          wx.setStorageSync('login',res)
                          uni.setStorageSync('login',res)
                          this.loginMsg = res
                          uni.switchTab({
                              url: '../me/me'
                          });
                      }).catch(err =>{
                          console.log("错误",err)
                      })
                      console.log("授权：",info)
                  }).catch(err =>{
                       console.log("授权失败！",err)
                  })
                  
              }).catch(err =>{
                  console.log("登录失败！",err)
              })
             this.$refs.popup.close()
            }
		},
        onLoad(){
            // 获取设备高度
            const { windowWidth, windowHeight } = uni.getSystemInfoSync();	
            this.width = windowWidth
            this.height = windowHeight
        }
	}
</script>

<style lang="scss" src="./index.scss" scoped></style>

