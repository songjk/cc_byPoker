// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html
var phpMethods = require("phpMethod").phpMethodList;
var postRepuests = require("netManager").postRepuest;
var HallManager = cc.Class({
    statics:{
        _instance:null,
    },
    requestHallRankList:function()
    {
        postRepuests(phpMethods.method_hallRankList, {}, 20000, function(data){
            var ret = data.ret;
            var friendIdList = ret.list;

        },function(data){
            cc.log("requestHallRankList failed:", data);
        },);
    },
});

HallManager._instance = new HallManager();
module.exports = HallManager;