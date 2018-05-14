var ShowAlertView = function(msg)
{
    jsb.reflection.callStaticMethod("nativeOcClass", "showAlertView:", msg);
};

var LoginWithType = function(iType)
{
    jsb.reflection.callStaticMethod("nativeOcClass", "loginWithType:", iType);
};
module.exports = {
    showAlertView : ShowAlertView,
    loginWithType: LoginWithType,
};
