<template>
    <div class="app">
        <div class="head">
            <AppHeader/>
        </div>
        <div class="container">
            <transition 
                v-if="hasMsg" 
                name="custom-classes-transition"
                enter-active-class="animated tada"
                leave-active-class="animated bounceOutRight">
                <Message/>
            </transition>
            <div class="alert alert-warning">
                Quizzy v0.1 beta Release.
            </div>
            <transition name="bounce">
                <router-view></router-view>
            </transition>
        </div>
        <AppFooter/>
        
    </div>
</template>

<script>
import AppHeader from './AppHeader.vue';
import Message from './partials/Message.vue';
import AppFooter from './partials/AppFooter.vue';

    export default {
        name:'App',
        components:{
            AppHeader,
            Message,
            AppFooter
        },
        computed:{
            hasMsg(){
                return this.$store.getters.getMessage;
            },
            isLoading(){
                return this.$store.getters.isLoading;
            }
        }
    }
</script>
<style scoped>
    .bounce-enter-active {
      animation: bounce-in .5s;
    }
    .bounce-leave-active {
      animation: bounce-in .5s reverse;
    }
    @keyframes bounce-in {
      0% {
        transform: scale(0);
      }
      50% {
        transform: scale(1.5);
      }
      100% {
        transform: scale(1);
      }
    }
    /* Enter and leave animations can use different */
    /* durations and timing functions.              */
    .slide-fade-enter-active {
      transition: all .3s ease;
    }
    .slide-fade-leave-active {
      transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
    }
    .slide-fade-enter, .slide-fade-leave-to
    /* .slide-fade-leave-active below version 2.1.8 */ {
      transform: translateX(10px);
      opacity: 0;
    }
</style>
