<template>
    <view class="content">
        <view class="control">
            <uni-segmented-control :current="current" :values="items" @clickItem="onClickItem" style-type="button" active-color="#8a8a8a"></uni-segmented-control>
        </view>
        <month v-if="current === 0" :famNum="famNum" :famName="famName" :key="current"></month>
        <year v-if="current === 1" :famNum="famNum" :famName="famName" :key="current"></year>
        
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
     import uniSegmentedControl from "@/components/uni-segmented-control/uni-segmented-control.vue"
     import month from './families/month.vue'
     import year from './families/year.vue'
export default {
    components: {
        uniSegmentedControl,
        month,
        year
    },
    data() {
        const loginMsg = wx.getStorageSync('login')
        return {
            items: ['月','年'],
            current: 0,
            famMenwShow:false,
            user:loginMsg.data,
            famlist:[],
            index:0,
            famNum:'',
            famName:'',
        };
    },
    methods:{
        onClickItem(e) {
           if (this.current !== e.currentIndex) {
               this.current = e.currentIndex;
           }
          
        }, 
        famlistChange(e){
            this.index = e.target.value
            this.famNum = this.famlist[this.index].famNum
            this.famName = this.famlist[this.index].famName
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
           }) 
        },        
    },
    mounted() {
        this.getfamlist()
    }
};
</script>

<style lang="scss" scoped></style>
