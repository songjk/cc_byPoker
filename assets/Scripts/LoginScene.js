// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

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
        var guestLoginTxt = this.getComponent("cc.Label");
        guestLoginTxt.string = "哈哈";
    },
    guestLogin:function (event, customData){
        console.log('clickGuest');
        var action = cc.moveTo(2, 100, 100);
        this.loginGuest.node.runAction(action);
    },
    sinaLogin:function (event, customData){
        console.log('clickSina');
        var action = cc.moveTo(2, 100, 100);
        this.loginSina.node.runAction(action);
    },
    start () {

    },

    // update (dt) {},
});
