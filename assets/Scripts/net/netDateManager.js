var httpRequest = require("httpRequest").requestManager;
var myMD5 = require('NTLMd5');
var appConfigs = require("appConfig").appConfigs;

var packageMothodAndParam = function(mothod, params){
    var result = {
        mid: 0,
        protocol : appConfigs.protocol,
        api: appConfigs.api,
        time : Date.parse(new Date()) / 1000,
        sid :  appConfigs.wetChatSid,
        langtype: appConfigs.langtype,
        username : "BOYAA_USER",
        version : appConfigs.version,
        mtkey : "",
        unid : appConfigs.unid,
        method : mothod,
        vkey: appConfigs.mtkey,
        param:{},
    };
    var newkey = Object.keys(params);
    for (var i = 0; i < newkey.length; i++) {//遍历newkey数组
        result.param[newkey[i]] = params[newkey[i]];
    }
    result.vkey = md5(appConfigs.vkey + "M");
    var sigInfo = joins(result, appConfigs.mtkey);
    result.sig = md5(sigInfo);
    result = "api=" + encodeURIComponent(JSON.stringify(result));
    
    return result;
};

var joins = function(data, mtkey)
{
    var str = appConfigs.key;
    if(typeof data == "undefined" || (typeof data === "boolean"))
    {
        return str;
    }
    else if(typeof data == "number" || typeof data == "string" )
    {
        var headstr = String(data);
        var patrn = /[^0-9a-zA-Z]/g;
        headstr = headstr.replace(patrn, "");
        headstr =headstr.replace(/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/g,"");
        str = str + "T" + mtkey + headstr;
    }
    else if(data instanceof Array )
    {
        var obj = new Object();
        for(var i=0;i<data.length;i++){
            var item = data[i];
            var keyitem = String(i);
            obj[keyitem] = item;
           }
           str = joins(obj, mtkey);
    }
    else if(data instanceof Object )
    {
        var newkey = Object.keys(data).sort();//排序
        for (var i = 0; i < newkey.length; i++) {//遍历newkey数组
            str = str + newkey[i] + "=" + joins(data[newkey[i]], mtkey);
        }
    }
    return str;
};


var md5 = function(text) {
    return cc.md5Encode(text).toLowerCase();
};

module.exports = {
    makeBody:packageMothodAndParam
};