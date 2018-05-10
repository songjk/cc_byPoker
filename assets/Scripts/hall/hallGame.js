// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

var postRepuests = require("netManager").postRepuest;
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
        var param = {
            appid : 1000,
            appkey : "init",
            curver : 140,
            ddid : ""
          }
          postRepuests("Members.prelogin", param, "http://android-poker-cn.17c.cn/api/api.php", 20000);
    },
    start () {

    },

    // update (dt) {},
});
