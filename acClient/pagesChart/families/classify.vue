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
                            <text class="t2">{{((item.count/sum)*100).toFixed(2)}}%</text>
                        </view>
                        <view class="c-line">
                            <view class="line" :style="{width:((item.count/sum)*100).toFixed(2)+'%'}" style="background-color:#FFBB77;"></view>
                        </view>
                    </view>
                    <view class="c-spend">
                        {{item.count}}
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
            billdata:[]
        };
    },
    methods:{
        getClassify(param){
            this.$myRequest({
                method:'POST',
                url:"/bill/families/familiesBill",
                data:param
            }).then(res =>{
                let {data} = res
                let oldData = []
                for(let i=0; i<data.length;i++){
                    if(data[i].quality == '1'){
                        let oldObj = {
                            icon_id:data[i].icon_id,
                            font_class:data[i].font_class,
                            name:data[i].name,
                            count:0,
                            quality:data[i].quality,
                            bill:[]
                        }
                        let billObj = {
                            spend:data[i].spend
                        }
                        
                        oldObj.bill.push(billObj)
                        oldData.push(oldObj)
                        if(data[i].spend < 0){
                            this.sum -= parseFloat(data[i].spend)                        
                        }
                    }
                }
                // 去重合并
                let newData = []
                let newObj = {}
                oldData.forEach((el,i) =>{
                   if(!newObj[el.icon_id]){
                       newData.push(el)
                       newObj[el.icon_id] = true
                   }else{
                       newData.forEach(el =>{
                           if(el.icon_id === oldData[i].icon_id){
                               el.bill = [...el.bill,...oldData[i].bill]
                           }
                       })
                   }
                    
                })
                newData.forEach(el =>{
                    let {bill} = el
                    for(let i=0;i<bill.length;i++){
                        el.count -= bill[i].spend
                    }
                })
                this.billdata = newData
            })
        }
    },
    onLoad(options) {
        this.date = options.date
        this.getClassify(options)
    }
};
</script>

<style lang="scss" src="./index.scss" scoped ></style>
