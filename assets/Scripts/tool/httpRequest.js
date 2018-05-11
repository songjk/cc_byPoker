// Learn cc.Class:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/class.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/class.html
// Learn Attribute:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/reference/attributes.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/reference/attributes.html
// Learn life-cycle callbacks:
//  - [Chinese] http://docs.cocos.com/creator/manual/zh/scripting/life-cycle-callbacks.html
//  - [English] http://www.cocos2d-x.org/docs/creator/en/scripting/life-cycle-callbacks.html

//网络请求（url，超时限制，请求成功回调，请求失败回调，发送数据）
var XML_HTTP_REQUEST = function(url, timeout, successCallback, failedCallback, sendData){
    // url = encodeURI(url);
    cc.log("url = " + url);
    var request = new XMLHttpRequest();
    var time = false;//是否超时
    var timer = setTimeout(function(){
        time = true;
        request.abort();//请求中止
        if(typeof failedCallback != "undefined"){
            failedCallback("请求超时");
            cc.log("XML_HTTP_REQUEST 请求超时");
        }
    },timeout);
    request.onreadystatechange = function(){
        if(request.readyState == 4) {
            cc.log("XML_HTTP_REQUEST request.readyState == 4");
            if(time) return;//请求已经超时，忽略中止请求
            clearTimeout(timer);//取消等待的超时
            if(request.status == 200){
                cc.log("XML_HTTP_REQUEST request.status == 200");
                successCallback(request.responseText);
            }else{
                if(typeof failedCallback != "undefined"){
                    failedCallback("请求失败");
                }
            }

        }
    }
    if(typeof sendData == "undefined"){
        request.open("GET",url, true);
        request.send();
        cc.log("XML_HTTP_REQUEST get open");
    }else{
        request.open("POST", url, true);
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.setRequestHeader("X-API-VER", "8");

        // 有head的时候需要设置如下内容
        request.setRequestHeader("api-v8", "1");
        request.setRequestHeader("X-TUNNEL-VERIFY", "2.0.0&84&XdO9sQ8q4oDT5dMKvdiSWBnLWFD/lRmVCli9etgrEWf/2Ge9Z70rUIN6ktOO06AWs9Pl09OO06CEFtPl01Bn047ToISE4oDT5dOh2l4MOe4Mk61PoGhroYLTjtOghITOreTT5dOVDFAMEf+V047TORaCaqBofdPl04BnEXorgysRGQrY/72DGZK9egqVvRmVelCAvYOA/2e9047TOcgWaJNqoGh90+XTkiu9UMsKvXoRepIRgCu9WGcRy3qSCpWAGVi9y4CDgCvTjtOzk+6ErdPl0xyCttq6047TFtnJ3dqzrcjT5dMWRn3agq21yRZeHMigk9rk047TFtnJf+6ErdPl0xZGfdqCrbXZydOO0xbZyc6t5NPl0xERDCvTjtMWaLegFsi95K2gttPl05PkHK3TjtNeh9qEreSgk9rk0+XTHP+tULMcZ5UosxwKkig5HGdQoBnTjtNeoKHLs7Pk0+XTK3rlWArlZ//lWCvlGXrlkhHTjtOCoF6t0+XTtxaCyrYcFidf492gob3a2ra1RuTa047Tgq2TutrkttPl08/i2OLTjtPahK2CKoDigNPl04MZ/3oRlWcRa9h6EZVr/5XYEWuSGYNYaxkZClBnUBlngIMZ2NOO04QWT63I0+XTEVAZWC4KUFjTjtNTFrPT5dODGf96EZVnEWvYehGVa/+V2BFrkhmDWGsZGQpQZ1AZZ4CDGdjTjtMtKw/Ls7Pk0+XTz+LY4tOO0y3Jra2z0+XTEStQ047TLSoWs9Pl01BnWBGSkiuVWNM/&DnHtkqlsnbHyx18mYuHylzac7Fc=");
        if(typeof sendData == "string"){
            request.send(sendData);
            cc.log("post send data is " + sendData);
        }else{
            var str = "";
            for (var key in sendData) {
                if (sendData.hasOwnProperty(key)) {
                    var element = sendData[key];
                    str += key + "=" + element + "&";
                }
            }
            str.substring(0, str.length -1);
            cc.log("post send data is " + str);
            request.send(str);
        }
        
    }
};

module.exports = {
    requestManager:XML_HTTP_REQUEST
};
