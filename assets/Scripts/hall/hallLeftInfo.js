// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html
const friendDatas = require("friendData").rankData;
var player = require("player").playerItem;
var invokeOC = require("invokeNativeFunc");
cc.Class({
    extends: cc.Component,

    properties: {
        headIcon:cc.Sprite,
        playerName:cc.Label,
        playerMoney:cc.Label,
        btnTask:cc.Button,
        btnStore:cc.Button,
        ranList:{
            default:null,
            type:cc.ScrollView,
        },
        playerItem:player,
        item:cc.Prefab,
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {},
    init:function(){
        // this.playerName.string = "O(∩_∩)O哈哈~";
        // this.playerMoney.string = "9999万块";
        // cc.loader.load("http://www.qqzhi.com/uploadpic/2014-09-28/135325755.jpg", function(err, texture){
        //     this.headIcon.spriteFrame.setTexture(texture);
        // }.bind(this));
        var num = cc.rand();
        if (num > 11) {
            this.playerItem.headIcon = "http://www.qqzhi.com/uploadpic/2014-09-28/135325880.jpg";
        } else if(num > 10) {
            this.playerItem.headIcon = "http://www.qqzhi.com/uploadpic/2014-09-28/135330636.jpg";
        }
        
        this.playerName.string = this.playerItem.playerName;
        this.playerMoney.string = this.playerItem.playerMoney
        cc.loader.load(this.playerItem.headIcon, function(err, texture){
            this.headIcon.spriteFrame.setTexture(texture);
        }.bind(this));
        this.setFriendRankList();
    },
    onTaskClicked:function(){
        cc.log("show hall task");
        invokeOC.showAlertView("Task is not ready");
    },
    onStoreClicked:function(){
        cc.log("show hall store");
        invokeOC.showAlertView("Store is not ready");
    },
    setFriendRankList:function(){
        for(var i = 0; i<friendDatas.length; i++)
        {
            var data = friendDatas[i];
            var player = cc.instantiate(this.item);
            player.getComponent("hallFriendItem").setData(data);
            this.ranList.content.addChild(player);
        }
    },
    start () {

    },

    // update (dt) {},
});
