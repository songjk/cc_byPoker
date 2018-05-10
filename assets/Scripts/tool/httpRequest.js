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
    //url = encodeURI(url);
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
