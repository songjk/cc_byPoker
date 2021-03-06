// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html
var invokeOC = require("invokeNativeFunc");
var loginManager = require("loginManage");
cc.Class({
    extends: cc.Component,

    properties: {
        // foo: {
        //     // ATTRIBUTES:
        //     default: null,        // The default value will be used only when the component attaching
        //                           // to a node for the first time
        //     type: cc.SpriteFrame, // optional, default is typeof default
        //     serializable: true,   // optional, default is true
        // },
        // bar: {
        //     get () {
        //         return this._bar;
        //     },
        //     set (value) {
        //         this._bar = value;
        //     }
        // },
        isAgreePivacy:false,
        loginGuest:{
            default:null,
            type:cc.Button,
        },
        loginSina:{
            default:null,
            type:cc.Button,
        }
    },

    // LIFE-CYCLE CALLBACKS:

    onLoad () {
        // var loginGuestEventHandler = new cc.Component.EventHandler();
        // loginGuestEventHandler.target = this.node;
        // loginGuestEventHandler.Component = "LoginScene";
        // loginGuestEventHandler.handler = "guestLogin";
        // loginGuestEventHandler.customEventData = "guest";
        // this.loginGuest.clickEvents.push(loginGuestEventHandler);
        console.log("loginScence onLoad--");

        // get sub node
        var label = cc.find("loginGuest/BtnGuestLabel", this.node);
        var labelT = label.getComponent(cc.Label);
        labelT.string = "GuestLogin";

        label = cc.find("Canvas/loginSina/BtnSinaLabel");
        labelT = label.getComponent(cc.Label);
        labelT.string = "SinaLogin";

        var view = cc.find("privaceContent", this.node);
        view.active = false;
        view.setScale(cc.v2(0,0));

        this.preLogin();
    },
    preLogin:function()
    {
        var loginManage = new loginManager();
        loginManage.preLogin();
    },
    guestLogin:function (event, customData){
        console.log('clickGuest');
        cc.director.loadScene("hallScene");
    },
    sinaLogin:function (event, customData){
        console.log('clickSina');
        invokeOC.loginWithType("5");
    },
    // 用户协议点击
    onPrivacyChanged:function(toggle, customEventData){
        this.isAgreePivacy = item.isChecked;
    },
    //显示用户协议内容
    showPrivacyContent:function(event, customData){
        var view = cc.find("privaceContent", this.node);
        view.active = true;
        var action = cc.scaleTo(0.2,1,1);
        view.runAction(action);

        this.setPrivacyIneractable(false);
    },
    //关闭用户协议内容
    closePrivacyContent:function(event, customData){
        var view = cc.find("privaceContent", this.node);
        
        var action = cc.scaleTo(0.2,0,0);
        var finished = cc.callFunc(function(){
            view.active = false;
        }, this, 1);
        var sec = cc.sequence(action, finished);
        view.runAction(sec);
        this.setPrivacyIneractable(true);
    },
    setPrivacyIneractable:function(flag){
        var buttonLabel = cc.find("agreementToggle/privaceLabel");
        var button = buttonLabel.getComponent(cc.Button);
        button.interactable = flag;
    },
    start () {
        
    },

    // update (dt) {},
});
