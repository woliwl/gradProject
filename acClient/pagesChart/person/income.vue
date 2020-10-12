<template>
    <view class="content">
        <view class="date" style="border-left: 15rpx solid #66B3FF;">
            {{date}}
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
                </view>
            </scroll-view>
        </view>
    </view>
</template>

<script>
export default {
    data() {
        return {
            sum:0,
            billdata:[],
            date:''
        };
    },
    methods:{
        getDayBill(param){
            this.$myRequest({
                method:'POST',
                url:"/bill/person/personBill",
                data:param
            }).then(res =>{
                let {data} = res
                data.forEach(el =>{
                    if(el.spend>0){
                        this.sum += parseFloat(el.spend)
                        this.billdata.push(el)
                    }
                })
                // console.log(this.allsum)
            })
            // console.log(this.billdata)
        }  
    },
    onLoad(options) {
       this.date = options.date
       // console.log(this.date,options)
       this.getDayBill(options)
    }
};
</script>

<style lang="scss" src="./index.scss" scoped></style>
