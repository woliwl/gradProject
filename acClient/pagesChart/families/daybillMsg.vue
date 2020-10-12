<template>
    <view class="content">
        <view class="date" style="border-left: 15rpx solid #FFBB77;">
            {{date}}
        </view>
        <view class="title">
            <text class="t1">总支出</text>
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
                            <text class="t1" style="color:#FFBB77;">{{item.name}}</text>
                            <text class="t2">{{item.date}}</text>
                        </view>
                        <view class="sub">
                          {{item.billsub}}
                        </view>
                    </view>
                    <view class="c-spend">
                        {{0-item.spend}}
                    </view>
                    <view class="avatar">
                        <image :src="item.avatarUrl" mode="aspectFill" class="img"></image>
                    </view>
                </view>
            </scroll-view>
        </view>
    </view>
</template>

<script>
export default {
    data() {
        return {
            date:'',
            sum:0,
            billdata:[],
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
                  if(el.spend<0){
                      this.sum -= parseFloat(el.spend)
                      this.billdata.push(el)
                  }
              })
              // console.log(this.allsum)
          })
      }  
    },
    onLoad(options) {
        this.date = options.date
        this.getDayBill(options)
    }
};
</script>

<style lang="scss" src="./index.scss" scoped></style>
