require('./bootstrap');

import Vue from 'vue';
import VueRouter from 'vue-router';
import Vuex from 'vuex';

import App from './components/App.vue';
import Home from './components/Home.vue';
import { routes } from './routes';
import StoreData from './store';
import {initialize} from './helpers/middleware';


Vue.use(VueRouter);
Vue.use(Vuex);

const store = new Vuex.Store(StoreData);

const router = new VueRouter({
	routes,
	mode:'history'
});

initialize(store,router);

const app = new Vue({
    el: '#app',
    router,
    store,
    components:{
    	App
    }
});
