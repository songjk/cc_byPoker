
var loginInfo = require("loginInfo");
var phpMethods = require("phpMethod").phpMethodList;
var postRepuests = require("netManager").postRepuest;
var invokeOC = require("invokeNativeFunc");
var LoginManage = cc.Class({
    loginWechat: function()
    {
        var token = loginInfo._instance.getWetchatToken();
        var openid = loginInfo._instance.getWetchatOpenid();
        var param = {
            token : token,
            appid : 1000,
            sitemid : openid,
            appkey : "init",
            curver : 150,
            APNSToken : "",
            APNSSetting : "",
          }
        postRepuests(phpMethods.method_SDKlogin, param, 20000, function(data){
            var ret = data.ret;
            var mid = ret.mid;
            if(mid)
            {
                if(mid > 0)
                {
                    invokeOC.showAlertView("login successful");
                }
                else
                {
                    invokeOC.showAlertView("login failed:", ret.dec);
                }
            }
        },function(data){
            cc.log("wetChat login failed:", data);
        },);
    },

    preLogin:function(){
        var param = {
            appid : 1000,
            appkey : "init",
            curver : 150,
            ddid : ""
          }
          postRepuests(phpMethods.method_Prelogin, param);
    },
});

module.exports = LoginManage;