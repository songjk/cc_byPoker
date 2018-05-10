
var makeBodys = require("netDateManager").makeBody;
var httpRequest = require("httpRequest").requestManager;
var requestWithMethodAndParam = function(method, param, url, timeout, successCallback, failedCallback)
{
    var body = makeBodys(method, param)
cc.log("requestWithMethodAndParam" + body);
    httpRequest(url, 200000, function(data){
        cc.log(data);
    },function(data){
        cc.log(data);
    }, body);
}

module.exports = {
    postRepuest:requestWithMethodAndParam
};