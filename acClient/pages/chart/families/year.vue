<template>
    <view class="content">
        <view class="uni-list">
               <view class="uni-list-cell">
                 <view class="uni-list-cell-db">
                     <picker mode="date" fields="year" :value="date" :start="startDate" :end="endDate" @change="bindDateChange">
                         <view class="uni-input">{{date}}</view>
                     </picker>
                  </view>
               </view>
            </view>
        
        <view class="chartsShowBox">
                <view class="line"></view>
                <view class="line_z"></view>
                <view class="midbox">
                <view class="income">
                    <text class="i1">本年收入</text>
                    <text class="i2">{{insum}}</text>
                    <view class="i3" @click="showIncome()">   
                        <text class="i3-text">查看详情</text>
                        <uni-icons class="i3-icon" type="arrowright" size="14" color="#6d6d6d"></uni-icons>
                    </view>
                </view>
                <!-- 图表-区域图 -->
                <view class="title">每月支出</view>
                <view class="chartsArea" >
                    <canvas canvas-id="canvasArea" id="canvasArea" class="area" 
                    @touchstart="touchArea"></canvas>
                </view>
                <!-- 图表-扇形图 -->
                <view class="title">
                    支出分类
                    <uni-tag text="查看全部" type="warning" size="small" @click="shompieMSg()"></uni-tag>
                </view>
                <view class="chartsPie">
                    <canvas canvas-id="canvasPie" id="canvasPie" class="pie" @touchstart="touchPie"></canvas>
                </view>
                <!-- 进度条 收支占比 -->
                <view class="line-title" v-if="insum > outsum">支出占收入百分比:{{((outsum/insum)*100).toFixed(2)}}%</view>
                <view class="inline" v-if="insum > outsum">
                    <view class="outline" :style="{width:((outsum/insum)*100).toFixed(2)+'%'}"></view>
                </view>
                </view>
            </view>
    </view>
</template>

<script>
    import uCharts from '../../../js_sdk/u-charts/u-charts/u-charts.js';
    import uniTag from "@/components/uni-tag/uni-tag.vue";
    var _self;
    var canvaArea=null, canvaPie=null;
    var cate = [],sadata=[],spdata=[];
export default {
    components: {uniTag},
    props:['famNum','famName'],
    data() {
        const currentDate = this.getDate({
           format: true
        })
        const loginMsg = wx.getStorageSync('login')
        return {
            fnum:'',
            cWidth:'',
            cHeight:'',
            cHeight_pie:'',
            insum:0,
            outsum:0,
            pixelRatio:1,
            date: currentDate,
            user:loginMsg.data,
            areaData: {
            	categories: cate,
            	series: [{
            		name: '支出',
            		data: sadata,
            		color: '#facc14'
            	}]
            },
            pieData:{
               "series": spdata
            },          
        };
    },
    computed:{
       startDate() {
           return this.getDate('start');
       },
       endDate() {
           return this.getDate('end');
       } 
    },
    methods:{
        bindDateChange(e){
            this.date = e.target.value
        },
        getDate(type){
          const date = new Date();
          let year = date.getFullYear();
          
          if (type === 'start') {
              year = year - 60;
          } else if (type === 'end') {
              year = year + 2;
          }
          return `${year}`;  
        }, 
        // 区域图
         showArea(canvasId,chartData){
            canvaArea=new uCharts({
                $this:_self,
                canvasId: canvasId,
                type: 'area',
                fontSize:10,
                legend:{show:false},
                dataLabel:false,
                dataPointShape:true,
                background:'#FFFFFF',
                pixelRatio:_self.pixelRatio,
                categories: chartData.categories,
                series: chartData.series,
                animation: false,
                dataPointShapeType:'hollow',
                xAxis: {
                    type:'grid',
                    gridColor:'#CCCCCC',
                    disableGrid:true,
                },
                yAxis: {
                    gridType:'solid',
                    disabled:true
                },
                width: _self.cWidth*_self.pixelRatio,
                height: _self.cHeight*_self.pixelRatio,
                extra: {
                    area:{
                        type: 'straight',
                        opacity:0.2,
                        addLine:true,
                        width:2
                    }
                }
            });  
         },
         touchArea(e) {
         	canvaArea.showToolTip(e, {
         		 format: function (item, category) {
         			return category + '号' + item.name + ':' + item.data + '元'
         		}
         	});
             // 获取折线图点击编号
             let areaindex = canvaArea.getCurrentDataIndex(e)
             let date = this.date + '-' + this.areaData.categories[areaindex]
             if(this.areaData.categories[areaindex]){
                 uni.navigateTo({
                     url:'../../pagesChart/families/daybillMsg?date='+date+"&famNum="+this.fnum
                 })
             }
         },
        
         // 饼图
         showPie(canvasId,chartData){
                 canvaPie=new uCharts({
                 $this:_self,
                 canvasId: canvasId,
                 type: 'pie',
                 fontSize:11,
                 legend:{
                 show:true,
                 position:'right',
                 float:'center',
                 itemGap:5,
                 padding:0,
                 lineHeight:20,
                 margin:0,
                 borderWidth :1,
                 fontSize:8*_self.pixelRatio
                 },
                 background:'#FFFFFF',
                 pixelRatio:_self.pixelRatio,
                 series: chartData.series,
                 animation: false,
                 width: _self.cWidth*_self.pixelRatio,
                 height: _self.cHeight_pie*_self.pixelRatio,
                 dataLabel: true,
                 extra: {
                     pie: {
                     lableWidth:15
                     }
                 },
             });
         },
         touchPie(e){
             canvaPie.showToolTip(e, {
                 format: function (item) {
                     return item.name + ':' + item.data + '￥'
                 }
             });
             // 获取饼图点击编号
             let pieindex = canvaPie.getCurrentDataIndex(e)
             // console.log(pieindex)
        },
        
        // 显示全部tag
        shompieMSg(){
            uni.navigateTo({
                url:'../../pagesChart/families/classify?date='+this.date+"&famNum="+this.fnum
            })
        },
        showIncome(){
            uni.navigateTo({
                url:'../../pagesChart/families/income?date='+this.date+"&famNum="+this.fnum
            })
        },
        // 获取当年账单
        getFamBill(){
            let date = {date:this.date},
                famNum = {famNum:this.fnum}
            let param = Object.assign(date,famNum)
            this.$myRequest({
                method:'POST',
                url:"/bill/families/familiesBill",
                data:param
            }).then(res =>{
                const {data} = res
                // console.log(data,param)
                data.forEach(el =>{
                    if(el.spend>0){
                        this.insum += parseFloat(el.spend)
                    }else{
                        this.outsum -= parseFloat(el.spend)
                    }
                })
                // 原数据转目标数据规则
                let oldData = [],_oldData = []
                for (let i=0;i<data.length;i++) {
                    let oldObj = {
                        date:data[i].date.substring(5,data[i].date.lastIndexOf('-')),
                        bill:[],
                        sum:0
                    }
                    let _oldObj = {
                        name:data[i].name,
                        bill:[],
                        sum:0
                    }
                    let billObj = {
                        id:data[i].id,
                        spend:data[i].spend,
                    }
                    oldObj.bill.push(billObj)
                    _oldObj.bill.push(billObj)
                    oldData.push(oldObj)
                    _oldData.push(_oldObj)
                }
                // 去重合并
                
                let newData = [], _newData = []//目标数据
                let newObj = {}, _newObj = {}
                oldData.forEach((el,i) =>{
                    if(!newObj[el.date]){
                        newData.push(el);
                        newObj[el.date] = true
                    }else{
                        newData.forEach(el =>{
                            if(el.date === oldData[i].date){
                                el.bill = [...el.bill,...oldData[i].bill]
                            }
                        })
                    }
                })
                _oldData.forEach((el,i)=>{
                    if(!_newObj[el.name]){
                        _newData.push(el);
                        _newObj[el.name] = true
                    }else{
                        _newData.forEach(el =>{
                            if(el.name === oldData[i].name){
                                el.bill = [...el.bill,...oldData[i].bill]
                            }
                        })
                    }
                })
                newData.forEach(el =>{
                    el.bill.forEach(item =>{
                        if(item.spend<0){
                            el.sum -= parseFloat(item.spend)
                        }
                    })
                    cate.push(el.date)
                    sadata.push(el.sum)
                })
                _newData.forEach(el =>{
                    let obj = {}
                    el.bill.forEach(item =>{
                        if(item.spend<0){
                            el.sum -= parseFloat(item.spend)
                        }
                    })
                    if(el.sum != 0){
                        obj.name = el.name
                        obj.data = el.sum
                        spdata.push(obj)
                    }                
                })
                
            })
        },
        
        // 清零
        clear(){
            this.areaData.categories.length = 0
            this.areaData.series[0].data.length = 0
            this.pieData.series.length = 0
            this.insum = 0
            this.outsum =0
        },
        // 防止组件切换数据不刷新
        reload(){
           this.clear()
           this.fnum = wx.getStorageSync('fnum')
           this.getFamBill() 
        }
        
    },
    updated() {
        this.showArea("canvasArea",this.areaData)
        this.showPie("canvasPie",this.pieData)
    },
    mounted() {
       _self = this;
       this.cWidth=uni.upx2px(640);
       this.cHeight=uni.upx2px(270);
       this.cHeight_pie=uni.upx2px(330);
       this.reload()
    },
    watch:{
       famNum:function(val) {
           wx.setStorageSync('fnum',val)
           this.reload()
       },
       date(dataVal){
           this.clear()
           this.date = dataVal
           this.getFamBill()
       }
    }
    
};
</script>

<style lang="scss" scoped></style>
