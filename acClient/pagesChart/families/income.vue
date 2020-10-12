<template>
    <view class="content">
        <view class="date" style="border-left: 15rpx solid #66B3FF;">
            {{date}}
        </view>
        <view class="famlines" @click="showFamline()">
            查看家庭成员收入占比
        </view>
        <view class="title">
            <text class="t1">总收入</text>
            <text class="t2">共{{billdata.length}}笔</text>
            <text class="t3">{{sum}}</text>
        </view>
     
        <view class="billBox">
            <scroll-view scroll-y="true" style="height:1200rpx;">
                <view class="list" v-for="(item,index) in billdata" :key="index">
                    <view class="icon">
                        <text class="iconfont" :class="item.font_class"></text>
                    </view>
                    <view class="classbox">
                        <view class="c-text">
                            <text class="t1" style="color:#66B3FF;">{{item.name}}</text>
                            <text class="t2">{{item.date}}</text>
                        </view>
                        
                        <view class="sub">
                          {{item.billsub}}
                        </view>
                    </view>
                    <view class="c-spend">
                       {{item.spend}}
                    </view>
                    <view class="avatar">
                        <image :src="item.avatarUrl" mode="aspectFill" class="img"></image>
                    </view>
                </view>
            </scroll-view>
        </view>
      
        <!-- 设计进度条弹窗 -->
        <uni-popup ref="famline" type="center">
            <view class="famBox">
                <scroll-view scroll-y="true" style="height: 900rpx;">
                <view class="linesBox" v-for="(item,index1) in fambilldata" :key="index1">
                    <view class="family-avatar">
                        <image :src="item.avatarUrl" mode="aspectFill" class="fam-img"></image>
                    </view>
                    <view class="family-name">{{decodeURIComponent(item.nickName)}}</view>
                    <view class="family-line">
                        <view class="family-line-z" :style="{width:((item.count/sum)*100).toFixed(2)+'%'}"></view>
                    </view>
                    <view class="exp">
                        <text class="e1">收入:{{item.count}}</text>
                        <text class="e2">占比:{{((item.count/sum)*100).toFixed(2)}}%</text>
                    </view>
                </view>
                </scroll-view>
            </view>
        </uni-popup>
        
    </view>
</template>

<script>
    import uniPopup from '@/components/uni-popup/uni-popup.vue'
export default {
    components:{uniPopup},
    data() {
        return {
            sum:0,
            billdata:[],
            date:'',
            fambilldata:[]
        };
    },
    methods:{
      getDayBill(param){
          this.$myRequest({
              method:'POST',
              url:"/bill/families/familiesBill",
              data:param
          }).then(res =>{
              let {data} = res
              data.forEach(el =>{
                  if(el.spend>0){
                      this.sum += parseFloat(el.spend)
                      this.billdata.push(el)
                  }
              })
              
              // 组合数组
              let oldData = []
              for (let i=0;i<this.billdata.length;i++) {
                  let oldObj = {
                      openid:this.billdata[i].openid,
                      nickName:this.billdata[i].nickName,
                      avatarUrl:this.billdata[i].avatarUrl,
                      count:0,
                      spend:[]
                  }
                  
                  let spendObj = {
                      spend:this.billdata[i].spend,
                  }
                  oldObj.spend.push(spendObj)
                  oldData.push(oldObj)
              }
               let newData = [],newObj = {}
               oldData.forEach((el,i) =>{
                   if(!newObj[el.openid]){
                       newData.push(el);
                       newObj[el.openid] = true
                   }else{
                       newData.forEach(el =>{
                           if(el.openid === oldData[i].openid){
                               el.spend = [...el.spend,...oldData[i].spend]
                           }
                       })
                   }
               })
               newData.forEach(el =>{
                   el.spend.forEach(e =>{
                       el.count += parseFloat(e.spend) 
                   })
               })
               this.fambilldata = newData
          })
          
      }, 
      showFamline(){
         this.$refs.famline.open()
      }
    },
    onLoad(options) {
        this.date = options.date
        this.getDayBill(options)
    }
};
</script>

<style lang="scss" src="./index.scss" scoped></style>
