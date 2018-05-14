//
//  LoginManager.m
//  template
//
//  Created by 兴斌 侯 on 3/22/16.
//
//

extern "C"
{
    const char* dict_get_string ( const char* strGroup, const char* strKey );
    int dict_get_int ( const char* strGroup, const char* strKey, int iDefaultValue );
    int dict_set_string ( const char* strGroup, const char* strKey, const char* strValue );
    int dict_set_int ( const char* strGroup, const char* strKey, const int iValue );
    int dict_set_double ( const char* strGroup, const char* strKey, double fValue );
    double dict_get_double ( const char* strGroup, const char* strKey, double fValue );
    int sys_set_string(const char* strKey, const char* strValue);
    int sys_set_int(const char* strKey, int iDefaultValue);
    int call_lua ( const char* strFunctionName );
}


#import "LoginManager.h"
#import "utility.h"
//#import "LuaEvent.h"
//#import "WeiboSDK.h"

#define PHP_RELOGIN_CODE      -5

static LoginManager * loginManager;

@interface LoginManager()

@end

@implementation LoginManager

@synthesize txConnectOAuth;

+(LoginManager*)sharedLoginManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManager = [[LoginManager alloc] init];
    });
    return loginManager;
}

-(id)init{
    if((self = ([super init]))){
        
    }
    return self;
}


+ (BOOL)handleOpenURL:(NSURL *)url{
    if (GetLoginType() == Login_WeChat)
    {
        return [[WeChatSSO weChatSingleton] handleUrl:url];
    }
    else if (GetLoginType() == Login_QQ)
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    return YES;
}


-(void)userLoginWithType:(LoginType)loginType{
    switch (loginType) {
        case Login_WeChat:
            [self userLoginWithWeChat];
            break;
        case Login_QQ:
            [self userLoginWithTXWeiBo];
            break;
        default:
            //不科学
            break;
    }
}

-(void)userLogoutWithType:(LoginType)loginType{
    switch (loginType) {
        case Login_WeChat:
            [[WeChatSSO weChatSingleton] logoutWechat];
            break;
        case Login_QQ:
            [TXWeiboUtil removeAuthParam];
            break;
        default:
            //不科学
            break;
    }
}

-(void)resetThirdPartyLoginWithType:(LoginType)loginType errorCode:(int)errorCode{
    switch (loginType) {    //暂时需求只有微信和新浪的需求
        case Login_Sina:
        case Login_WeChat:
        case Login_QQ:
        case Login_BoYaa:
        {
            [self userLogoutWithType:loginType];    //删除登出
            if(errorCode == PHP_RELOGIN_CODE){
                [self userLoginWithType:loginType]; //重新获取
            }
        }
            break;
        default:
            NSLog(@"不处理");
            break;
    }
    
}



#pragma mark -- 微信登录
-(void)userLoginWithWeChat{
    [WeChatSSO weChatSingleton].delegate = self;
    [[WeChatSSO weChatSingleton] WeChatLoginEntrance];
}

-(void)LoginWechatWithData:(WechatAuthParams*)data
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            data.accessToken,@"accessToken",
                            data.openID,@"openid",
                            nil];
//    SEND_DATA_TOLUA(@"login_Weixin",params);
}

#pragma mark--WeChatSSODelegate
-(void)LoginWechatWithCode:(NSString*)resultRespCode{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            resultRespCode,@"tokenCode",
                            nil];
//    SEND_DATA_TOLUA(@"login_Weixin",params);
}
-(void)loginFailedWithErrorWithResult:(int)result withErrorMsg:(NSString*)errorMsg{
    // 为了和android保持一致 error_code ＝ －1；
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            errorMsg,@"msg",
                            [NSString stringWithFormat:@"%d",-1],@"error_code",
                            nil];

//    SEND_DATA_TOLUA(@"login_Weixin",params);
}



#pragma mark -- QQ登录
-(void)userLoginWithTXWeiBo{
    self.txConnectOAuth = [TXOAuthObject shareTecentOAuth].tencentOAuth;
    self.txConnectOAuth.sessionDelegate = self;
    TXWeiboAuthParam *param = [TXWeiboUtil loadAuthParam];
    if ([TXWeiboUtil isValidParam:param]) {
        if (self.txConnectOAuth == nil) {
            self.txConnectOAuth.accessToken = param.accessToken;
            self.txConnectOAuth.openId = param.openid;
            self.txConnectOAuth.expirationDate = [NSDate dateWithTimeIntervalSince1970: [param.expireIn floatValue]];
        }
        [self loginTXWeiBo:param];
        
    }
    else{
        [TXWeiboUtil removeAuthParam];
        if (([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) || ([TencentOAuth iphoneQZoneInstalled] && [TencentOAuth iphoneQZoneSupportSSOLogin])) {
            [self startTXWeiboAuth];
        }else{
            [self startTXWeiboAuth];
        }
    }

}

- (void)startTXWeiboAuth
{
    //self.txConnectOAuth = [[TencentOAuth alloc] initWithAppId:@"23006" andDelegate:self];
    NSArray* permissions =  [NSArray arrayWithObjects:@"get_simple_userinfo",@"upload_pic",@"add_topic",@"add_pic_t",@"get_fanslist",@"get_idollist", nil];
    [self.txConnectOAuth authorize:permissions];
    
}

- (void)txWeiboLogout
{
    [TXWeiboUtil removeAuthParam];
}
-(void)onReq:(QQBaseReq *)req
{
    
}
-(void)onResp:(QQBaseResp *)resp
{
    
}
-(void)isOnlineResponse:(NSDictionary *)response
{
    
}
#pragma mark - TencentLoginDelegate(授权登录回调协议)

- (void)tencentDidLogin
{
    TXWeiboAuthParam *param = [[TXWeiboAuthParam alloc] init];
    param.accessToken = self.txConnectOAuth.accessToken;
    param.openid = self.txConnectOAuth.openId;
    param.expireIn = [NSString stringWithFormat:@"%f", [self.txConnectOAuth.expirationDate timeIntervalSince1970]];
    [TXWeiboUtil saveAuthParam:param];
    
    [self loginTXWeiBo:param];
}

/**
 * 登录失败后的回调
 * param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSString * errorMsg = @"QQ授权异常，取消操作";
    if (cancelled) {
        errorMsg = @"用户取消登录";
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            errorMsg, @"msg",
                            nil];
//    SEND_DATA_TOLUA(@"login_QQ",params);
    //如果有问题再次清理本机的数据
    [TXWeiboUtil removeAuthParam];
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"手机网络无法连接",@"msg",
                            nil];
//    SEND_DATA_TOLUA(@"login_QQ",params);
    //如果有问题再次清理本机的数据
    [TXWeiboUtil removeAuthParam];
}

- (void)loginTXWeiBo:(TXWeiboAuthParam *)param
{
    if (param.accessToken == nil || param.openid == nil || param.expireIn == nil) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"QQ授权异常，请再次授权",@"msg",
                                nil];
//        SEND_DATA_TOLUA(@"login_QQ",params);
        
        //如果有问题再次清理本机的数据
        [TXWeiboUtil removeAuthParam];
        return;
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            param.accessToken,@"access_token",
                            param.openid,@"openid",
                            param.expireIn,@"expires_in",
                            nil];
//    SEND_DATA_TOLUA(@"login_QQ",params);
}


- (CGAffineTransform)transformForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return CGAffineTransformIdentity;
    }
    
    if (orientation == UIInterfaceOrientationLandscapeLeft)
    {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight)
    {
        return CGAffineTransformMakeRotation(M_PI/2);
    }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return CGAffineTransformMakeRotation(-M_PI);
    }
    else
    {
        return CGAffineTransformIdentity;
    }
}
@end
