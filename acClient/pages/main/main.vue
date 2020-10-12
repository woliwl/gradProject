<template>
	<view>
        <!--我的/家庭切换 -->
        <view class="segment">
            <uni-fab
               :pattern="pattern"
               :content="content"
               :horizontal="horizontal"
               :vertical="vertical"
               :direction="direction"
               @trigger="trigger"
            ></uni-fab>
        </view>
        
        <!-- 内容 -->
        <view class="content">
            <person v-if="current === 0"></person>
            <families v-if="current === 1"></families>
        </view>
		  
	</view>
</template>

<script>
    import uniFab from '@/components/uni-fab/uni-fab.vue';
    import person from './person.vue';
    import families from './families.vue';
	export default {
        components: {person,families,uniFab},
		data() {
			return {
                // 小菜单
                current: 0,
                horizontal: 'left',
                vertical: 'bottom',
                direction: 'vertical',
                pattern: {
                   color: '#8a8a8a',
                   backgroundColor: '#fff',
                   selectedColor: '#FB9B5E',
                   buttonColor:"#FB9B5E",
                },
                content:[
                    {
                       text: '我的',
                       active: true
                    },
                    {
                       text: '家庭',
                       active: false
                    }
                ],
			};
		},
        methods:{
            trigger(e) {
                let other = this.content.map((d, i) => {
                   d.active = i== e.index
                })
                this.current = e.index
            },            
        }
        
	}
</script>
