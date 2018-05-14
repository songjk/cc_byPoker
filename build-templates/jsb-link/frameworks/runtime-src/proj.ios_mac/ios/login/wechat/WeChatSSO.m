//
//  WeChatSSO.m
//  template
//
//  Created by Blade on 15/3/23.
//
//

#import "WeChatSSO.h"
#import "SFHFKeychainUtils.h"
//#import "SelfDefine.h"
#import "utility.h"

@implementation WechatAuthParams
- (NSString *)description {
    return [NSString stringWithFormat:@"access_token:%@\nrefresh_token:%@\nexpire_in:%@\nopenid:%@\nscope:%@\n",_accessToken, _refreshToken, _expireTime, _openID, _scope];
}
@end

static WeChatSSO *weChatSSOSingleton;


@implementation WeChatSSO

+(WeChatSSO *)weChatSingleton{
    if (weChatSSOSingleton == nil) {
        weChatSSOSingleton = [[WeChatSSO alloc] init];
    }
    return weChatSSOSingleton;
};

-(void)WeChatLoginEntrance{
    if ([self isWechatAuthed]) {
        // [self loginWechat];
        WechatAuthParams *cache = [self loadWechatAuthParams];
        if ([self isTokenExpired:cache.expireTime]) {
            [self initWechatAuth];
            return;
        }
        if(self.delegate){
            [self.delegate LoginWechatWithData:cache];
        }
    } else {
        [self initWechatAuth];
    }
}

- (void)logoutWechat {
    [self removeWechatAuthParams];
}

-(void)LoginErrorWithResult:(int)result withMsg:(NSString*)errorMsg{
    if(self.delegate){
        [self.delegate loginFailedWithErrorWithResult:result withErrorMsg:errorMsg];
    }
}

- (BOOL)isTokenExpired:(NSString *)timeStr{
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSince1970:[timeStr floatValue]];
    NSDate *now = [NSDate date];
    BOOL flag = [now compare:expirationDate] == NSOrderedDescending;
    if (flag) {
        [self removeWechatAuthParams];
    }
    return flag;
}
- (void)loginWechat {
    WechatAuthParams *cache = [self loadWechatAuthParams];
    if (!cache || [self isTokenExpired:cache.expireTime]) {
        [self refreshTokenWithToken:cache.refreshToken];
        return;
    }
    if(self.delegate){
        [self.delegate LoginWechatWithData:cache];
    }
}
#pragma mark - Wechat auth api
- (void)fetchTokenWithCode:(NSString *)code {
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WECHAT_APPID, WECHAT_SECRET, code]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSError *error = nil;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:NULL
                                                         error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (data) {
                NSDictionary *retDic = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
                if (retDic && [retDic isKindOfClass:[NSDictionary class]]) {
                    NSString *errStr = retDic[@"errmsg"];
                    if (errStr && [errStr isKindOfClass:[NSString class]]) {
                        [self LoginErrorWithResult:1 withMsg:errStr];
                    } else {
                        [self saveWechatAuthParams:retDic];
                        [self loginWechat];
                    }
                } else {
                    [self LoginErrorWithResult:1 withMsg:error.localizedDescription];
                }
            } else {
                [self LoginErrorWithResult:1 withMsg:error.localizedDescription];
            }
        });
    });
}

- (void)refreshTokenWithToken:(NSString *)token {
    //用refresh token刷新token有效期
    //https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&grant_type=refresh_token&refresh_token=REFRESH_TOKEN
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WECHAT_APPID, token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSError *error = nil;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:NULL
                                                         error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (data) {
                NSDictionary *retDic = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&error];
                if (retDic && [retDic isKindOfClass:[NSDictionary class]]) {
                    NSString *errStr = retDic[@"errmsg"];
                    if (errStr && [errStr isKindOfClass:[NSString class]]) {
//                        [self loginFailedWithError:nil];
                        [self initWechatAuth];
                    } else {
                        [self saveWechatAuthParams:retDic];
                        [self loginWechat];
                    }
                } else {
                    [self LoginErrorWithResult:1 withMsg:error.localizedDescription];
                }
            } else {
                [self LoginErrorWithResult:1 withMsg:error.localizedDescription];
            }
        });
    });
}

- (void)initWechatAuth {
    BOOL isWXAppInstalled = [WXApi isWXAppInstalled];
    //BOOL isWXAppSupportApi = [WXApi isWXAppSupportApi];
    if (isWXAppInstalled ) {  // && isWXAppSupportApi
        SendAuthReq* req =[[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
    } else {
        int result = 1;
        NSString *errorMsg = [NSString string];
        if(!isWXAppInstalled){
            result = 2;
            errorMsg = @"未安装微信";
        }
//        else if (!isWXAppSupportApi){
//            result = 3;
//            errorMsg = @"微信版本过低";
//        }
        if(self.delegate){
            [self.delegate loginFailedWithErrorWithResult:result withErrorMsg:errorMsg];
        }
    }
}

#pragma mark - keychain
- (BOOL)isWechatAuthed {
    WechatAuthParams *params = [self loadWechatAuthParams];
    if (params) {
        return YES;
    }
    return NO;
}

- (void)saveWechatAuthParams:(NSDictionary *)params {
//    [SFHFKeychainUtils storeUsername:WECHAT_CODE_TOKEN
//                             andPassword:params[@"codeToken"]
//                          forServiceName:PokerKingServiceName
//                          updateExisting:YES
//                                   error:nil];
    if (!IsNoEmptyString(params[@"access_token"])
        || !IsNoEmptyString(params[@"refresh_token"])
        || !IsNoEmptyString(params[@"openid"])) {
        return;
    }
    [SFHFKeychainUtils storeUsername:WECHAT_ACCESS_TOKEN
                         andPassword:params[@"access_token"]
                      forServiceName:TexasCnServiceName
                      updateExisting:YES
                               error:nil];
    [SFHFKeychainUtils storeUsername:WECHAT_REFRESH_TOKEN
                         andPassword:params[@"refresh_token"]
                      forServiceName:TexasCnServiceName
                      updateExisting:YES
                               error:nil];
    [SFHFKeychainUtils storeUsername:WECHAT_OPEN_ID
                         andPassword:params[@"openid"]
                      forServiceName:TexasCnServiceName
                      updateExisting:YES
                               error:nil];
    [SFHFKeychainUtils storeUsername:WECHAT_EXPIRE_TIME
                         andPassword:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970] + [params[@"expires_in"] doubleValue]]
                      forServiceName:TexasCnServiceName
                      updateExisting:YES
                               error:nil];
}

- (WechatAuthParams *)loadWechatAuthParams {
    WechatAuthParams *params = [[WechatAuthParams alloc] init];
//    params.codeToken = [SFHFKeychainUtils getPasswordForUsername:WECHAT_CODE_TOKEN
//                                                        andServiceName:PokerKingServiceName
//                                                                 error:nil];
//    if (!IsNoEmptyString(params.codeToken)) {
//            return nil;
//    }
    params.accessToken = [SFHFKeychainUtils getPasswordForUsername:WECHAT_ACCESS_TOKEN
                                                    andServiceName:TexasCnServiceName
                                                             error:nil];
    params.refreshToken = [SFHFKeychainUtils getPasswordForUsername:WECHAT_REFRESH_TOKEN
                                                     andServiceName:TexasCnServiceName
                                                              error:nil];
    params.openID = [SFHFKeychainUtils getPasswordForUsername:WECHAT_OPEN_ID
                                               andServiceName:TexasCnServiceName
                                                        error:nil];
    params.expireTime = [SFHFKeychainUtils getPasswordForUsername:WECHAT_EXPIRE_TIME
                                                   andServiceName:TexasCnServiceName
                                                            error:nil];
    if (!IsNoEmptyString(params.accessToken)
        || !IsNoEmptyString(params.refreshToken)
        || !IsNoEmptyString(params.openID)) {
        return nil;
    }
    return params;
}

- (void)removeWechatAuthParams {
//    [SFHFKeychainUtils deleteItemForUsername:WECHAT_CODE_TOKEN
//                              andServiceName:PokerKingServiceName
//                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:WECHAT_ACCESS_TOKEN
                              andServiceName:TexasCnServiceName
                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:WECHAT_EXPIRE_TIME
                              andServiceName:TexasCnServiceName
                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:WECHAT_REFRESH_TOKEN
                              andServiceName:TexasCnServiceName
                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:WECHAT_OPEN_ID
                              andServiceName:TexasCnServiceName
                                       error:nil];
}

- (BOOL)handleUrl:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - Wechat delegate
-(void) onReq:(BaseReq*)req{
    //微信发起请求过来
}

-(void) onResp:(BaseResp*)resp{
    //微信回应请求过来
    if (resp && [resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *resultResp = (SendAuthResp *)resp;
        switch (resultResp.errCode) {
            case ERR_OK:{
                DebugLog(@"微信授权code:%@", resultResp.code);
                [self fetchTokenWithCode:resultResp.code];
//                if(self.delegate){
//                    [self.delegate LoginWechatWithData:resultResp.code];
//                }
            }
                break;
            case ERR_AUTH_DENIED:{
                NSLog(@"user denied auth");
                if(self.delegate){
                    [self.delegate loginFailedWithErrorWithResult:resultResp.errCode withErrorMsg:@"用户拒绝认证"];
                }
            }
                break;
            case ERR_USER_CANCEL:{
                NSLog(@"user canceled auth");
                if(self.delegate){
                    [self.delegate loginFailedWithErrorWithResult:resultResp.errCode withErrorMsg:@"用户取消登录"];
                }
            }
                break;
            default:
            break;
        }
    }
}
@end
