// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html
var AccountInfo = require("accountInfo");
const friendDatas = require("friendData").rankData;
// var player = require("player").playerItem;
var invokeOC = require("invokeNativeFunc");
var HallManager = require("hallManager");
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
        // playerItem:player,
        item:cc.Prefab,
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {},
    init:function(){
        // var num = cc.rand();
        // if (num > 11) {
        //     this.playerItem.headIcon = "http://www.qqzhi.com/uploadpic/2014-09-28/135325880.jpg";
        // } else if(num > 10) {
        //     this.playerItem.headIcon = "http://www.qqzhi.com/uploadpic/2014-09-28/135330636.jpg";
        // }
        
        // this.playerName.string = this.playerItem.playerName;
        // this.playerMoney.string = this.playerItem.playerMoney
        // cc.loader.load(this.playerItem.headIcon, function(err, texture){
        //     this.headIcon.spriteFrame.setTexture(texture);
        // }.bind(this));

        this.setFriendRankList();

        this.playerName.string = AccountInfo._instance.playerName;
        this.playerMoney.string = String(AccountInfo._instance.money);
        var url = AccountInfo._instance.iconUrl;
        if(typeof url !== "string")
        {
            url = "http://www.qqzhi.com/uploadpic/2014-09-28/135330636.jpg";
        }
        var length = url.length;
        var imageType = url.substring(length-3, length);
        cc.log("initPlayerInfo:", url);
        if(imageType == "jpg" || imageType == "png" || imageType == "peg")
        {
            cc.loader.load(url, function(err, texture){
                this.headIcon.spriteFrame.setTexture(texture);
            }.bind(this));
        }
        else
        {
            cc.loader.load({url:url, type:"jpg"}, function(err, texture){
                this.headIcon.spriteFrame.setTexture(texture);
            }.bind(this));
        }
        
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
        var resultData = [];
        HallManager._instance.requestHallRankList(function(data){
            if(data && data instanceof Array )
            {
                resultData = data;
            }
            else
            {
                resultData = friendDatas;
            }
        for(var i = 0; i<resultData.length; i++)
        {
            var data = resultData[i];
            var player = cc.instantiate(this.item);
            player.getComponent("hallFriendItem").setData(data);
            this.ranList.content.addChild(player);
        }
        }.bind(this));
    },
    start () {

    },

    // update (dt) {},
});
