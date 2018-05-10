var httpRequest = require("httpRequest").requestManager;
 var myMD5 = require('NTLMd5');
var appConfigs = require("appConfig").appConfigs;

var packageMothodAndParam = function(mothod, params){
    var result = {
        api: 25,
        langtype: 1,
        method : mothod,
        //method: "Members.prelogin",
        mid: 0,
        mtkey : "",
        protocol : 1,
        sid :  "117",
        time : 1525924825,
        unid : "140",
        username : "BOYAA_USER",
        version : "6.2.140",
        param:params,
        vkey: "",
    };
    result.vkey = md5("M");
    var sigInfo = joins(result, appConfigs.mtkey);
    result.sig = md5(sigInfo);
    result = "api=" + JSON.stringify(result);
    
    return result;
};

var joins = function(data, mtkey)
{
    var str = appConfigs.key;
    if(!data || (data instanceof Boolean))
    {
        return str;
    }
    else if(typeof data == "number" || typeof data == "string" )
    {
        var headstr = String(data);
        var patrn = /[^0-9a-zA-Z]/;
        headstr.replace(patrn, "");
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