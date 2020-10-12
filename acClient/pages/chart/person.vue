<template>
    <view class="content">
        <view class="control">
             <uni-segmented-control :current="current" :values="items" @clickItem="onClickItem" style-type="button" active-color="#8a8a8a"></uni-segmented-control>
        </view>
        <month v-if="current === 0" :piemargin="piemargin" :key="monthKey"></month>
        <year v-if="current === 1" :piemargin="piemargin" :key="yearKey"></year>
    </view>
</template>

<script>
    import uniSegmentedControl from "@/components/uni-segmented-control/uni-segmented-control.vue"
    import month from './person/month.vue'
    import year from './person/year.vue'
export default {
    props:['piestyle'],
    components: {
        uniSegmentedControl,
        month,
        year, 
    },
    data() {
        return {
            items: ['月','年'],
            current: 0,
            piemargin:''
        };
    },
    methods:{
        onClickItem(e) {
           if (this.current !== e.currentIndex) {
               this.current = e.currentIndex;
               
           }
        },   
    },
    watch:{
        piestyle:function(val) {
            this.piemargin = val
        },
    },
    
};
</script>

<style lang="scss" src="./chart.scss" scoped></style>
