//
//  WeChatSSO.h
//  template
//
//  Created by Blade on 15/3/23.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

#ifdef ISDOUPAI
#define WECHAT_APPID            @"wx9465d0bf85a6110d"
#define WECHAT_SECRET           @"444b815f69611336dbb68f57eec542f8"
#define WECHAT_MERCHANT_ID      @"1316321501"

#define TexasCnServiceName    @"com.boyaa.texas-doupai-cn"
#else
#define WECHAT_APPID            @"wxc07ff85e06198e46"
#define WECHAT_SECRET           @"24cecdf0813fd66a41df242014d1f09a"
#define WECHAT_MERCHANT_ID      @"1309738101"

#ifdef ISIPAD
#define TexasCnServiceName    @"com.boyaa.pokerHD-CN"
#else
#define TexasCnServiceName    @"com.by.texas-cn"
#endif

#endif

#define WECHAT_ACCESS_TOKEN     @"WechatAccessToken"
#define WECHAT_EXPIRE_TIME      @"WechatExpireTime"
#define WECHAT_REFRESH_TOKEN    @"WechatRefreshToken"
#define WECHAT_OPEN_ID          @"WechatOpenID"
#define WECHAT_Scope            @"WechatScope"

typedef enum : int {
    ERR_OK = 0,//(用户同意)
    ERR_AUTH_DENIED = -4,//（用户拒绝授权）
    ERR_USER_CANCEL = -2,//（用户取消）
} ErrCode;

@interface WechatAuthParams : NSObject
@property (nonatomic, retain)NSString *accessToken;
@property (nonatomic, retain)NSString *refreshToken;
@property (nonatomic, retain)NSString *openID;
@property (nonatomic, retain)NSString *expireTime;
@property (nonatomic, retain)NSString *scope;
@end

@protocol WeChatSSODelegate <NSObject>
@required
-(void)LoginWechatWithData:(WechatAuthParams*)data;
//-(void)LoginWechatWithCode:(WechatAuthParams*)resultRespCode;
-(void)loginFailedWithErrorWithResult:(int)result withErrorMsg:(NSString*)errorMsg;
@end

@interface WeChatSSO : NSObject<WXApiDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property(nonatomic,assign)id<WeChatSSODelegate> delegate;

+ (WeChatSSO *)weChatSingleton;
- (void)WeChatLoginEntrance;
- (void)logoutWechat;
- (BOOL)handleUrl:(NSURL *)url;
@end
