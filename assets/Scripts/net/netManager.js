
var appConfigs = require("appConfig").appConfigs;
var makeBodys = require("netDateManager").makeBody;
var httpRequest = require("httpRequest").requestManager;
var requestWithMethodAndParam = function(method, param, timeout, successCallback, failedCallback, url)
{
    var body = makeBodys(method, param)
cc.log("requestWithMethodAndParam body :" + body);
    httpRequest(appConfigs.urlstr, 20000, function(data){
        cc.log(data);
    },function(data){
        cc.log(data);
    }, body);
}

module.exports = {
    postRepuest:requestWithMethodAndParam
};