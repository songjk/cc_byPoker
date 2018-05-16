var phpMethods = require("phpMethod").phpMethodList;
var appConfigs = require("appConfig").appConfigs;
var makeBodys = require("netDateManager").makeBody;
var httpRequest = require("httpRequest").requestManager;
var requestWithMethodAndParam = function(method, param, timeout, successCallback, failedCallback, url)
{
    var head = false;
    if(method == phpMethods.method_SDKlogin || method == phpMethods.method_Prelogin)
    {
        head = true;
    }
    var body = makeBodys(method, param)
cc.log("requestWithMethodAndParam body :" + body);
    httpRequest(appConfigs.urlstr, 20000, function(data){
        cc.log(data)
        var result = JSON.parse(data);
        if(typeof successCallback != "undefined"){
            successCallback(result);
        }else{
            if(typeof failedCallback != "undefined"){
                failedCallback("请求失败");
            }
        }
    },function(data){
        cc.log(data);
    }, body, head);
}

module.exports = {
    postRepuest:requestWithMethodAndParam
};