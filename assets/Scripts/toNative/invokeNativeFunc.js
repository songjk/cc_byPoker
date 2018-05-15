var ShowAlertView = function(msg)
{
    if(cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS){
        jsb.reflection.callStaticMethod("nativeOcClass", "showAlertView:", msg);
    }
};

var LoginWithType = function(iType)
{
    if(cc.sys.isNative && cc.sys.os == cc.sys.OS_IOS){
        jsb.reflection.callStaticMethod("nativeOcClass", "loginWithType:", iType);
    }
};
module.exports = {
    showAlertView : ShowAlertView,
    loginWithType: LoginWithType,
};
