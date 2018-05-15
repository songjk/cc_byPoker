

var LoginInfos = cc.Class({
    wetchatToken:"",
    wetchatOpenidJ:"",
    statics: {
        _instance: null,
    },
    setWetchatToken:function(token){
        this.wetchatToken = token;
    },
    setWetchatOpenid:function(openid){
        this.wetchatOpenid = openid;
    },
    getWetchatToken:function(){
        return this.wetchatToken;
    },
    getWetchatOpenid:function(){
        return this.wetchatOpenid;
    },
});

LoginInfos._instance = new LoginInfos();
module.exports = LoginInfos;