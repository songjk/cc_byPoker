var loginInfo = require("loginInfo");
var loginManager = require("loginManage");
window.loginWechat = (token, openid)=>{
    cc.log('window.loginWechat' , token + openid)
    loginInfo._instance.setWetchatToken(token);
    loginInfo._instance.setWetchatOpenid(openid);
    var loginManage = new loginManager();
    loginManage.loginWechat();
}