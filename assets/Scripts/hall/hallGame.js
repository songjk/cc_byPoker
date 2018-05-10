// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html
var httpRequest = require("httpRequest").requestManager;

cc.Class({
    extends: cc.Component,

    properties: {
        leftInfo:cc.Node,
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {
        this.leftInfo = this.leftInfo.getComponent("hallLeftInfo")

        this.leftInfo.init();

        this.requestHallInfo()
        
    },
    requestHallInfo:function(){
        // var httpRequest = new XMLHttpRequest();
        // httpRequest.onreadystatechange = function(){
        //     var response = httpRequest.responseText;
        //     cc.log("request--");
        //     cc.log(response);
        // };
        // httpRequest.open("GET","https://www.baidu.com", true);
        // httpRequest.send();
        httpRequest("https://www.baidu.com", 200000, function(data){
            cc.log(data);
        },function(data){
            cc.log(data);
        });
    },
    start () {

    },

    // update (dt) {},
});
