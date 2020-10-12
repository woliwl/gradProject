<template>
	<view class="content">
        <view class="imgbox">
            <image class="img" :src="userMsg.avatarUrl" mode="aspectFill"></image>
        </view>
        <view class="name">
            <text>{{userMsg.nickName}}</text><br/>
            <text>你终于来了！等你很久了~</text>
        </view>
        <view class="list">
             <uni-list>
                <uni-list-item :show-extra-icon="true" :extra-icon="home" 
                title="我的家庭" @click="goFamilies()"></uni-list-item>
                <uni-list-item :show-extra-icon="true" :extra-icon="star" 
                title="我的负债" @click="myDebts()"></uni-list-item>
                <uni-list-item :show-extra-icon="true" :extra-icon="help" 
                title="关于小程序" @click="about()"></uni-list-item>
                <!-- <uni-list-item title="默认 navigateTo 方式跳转页面" link to="/pages/vue/index/index" @click="onClick($event,1)" ></uni-list-item> -->
            </uni-list>
        </view>
        <view class="btnbox">
            <button class="btn" type="default" open-type="feedback" size="mini">
                <uni-icons type="phone" size="24" color="#fff" class="icon-phone"></uni-icons> 
            </button>
        </view>
        <view class="popup">
            <uni-popup ref="popup" type="center">
                <view class="dialog">
                    <image class="icon" src="../../static/icon/logo_.png" mode="aspectFill">
                    <text decode class="text">&nbsp;&nbsp;家庭记账本，一款多人记账的小程序，您可以与你的家人、爱人、朋友共同经营账单~</text>
                </view>
            </uni-popup>
        </view>
	</view>    
</template>

<script>
    import uniList from '@/components/uni-list/uni-list.vue'
    import uniListItem from '@/components/uni-list-item/uni-list-item.vue'
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
	export default {
        components: {
            uniList,
            uniListItem,
            uniPopup
        },
		data() {
			return {
				userMsg:'',
                star:{color:'#8a8a8a',size:'15',type:'star'},
                home:{color:'#8a8a8a',size:'15',type:'home'},
                help:{color:'#8a8a8a',size:'15',type:'help'},
			};
		},
        methods:{
            goFamilies(){
                uni.navigateTo({
                    url:"../../pagesFam/home/home"
                })
            },
            about(){
                 this.$refs.popup.open()
            },
            myDebts(){
                console.log("如何设计我的负债？")
            }
        },
        onLoad() {
            let user = wx.getStorageSync('userMsg')
            this.userMsg = user[1].userInfo
            let loginMsg = wx.getStorageSync('login')
            console.log(loginMsg)
        }
	}
</script>

<style lang="scss" src="./me.scss">

</style>
