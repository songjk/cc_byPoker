//
//  LoginManager.h
//  template
//
//  Created by 兴斌 侯 on 3/22/16.
//
//

#import <Foundation/Foundation.h>
//#import "SelfDefine.h"
//#import "SinaSSO.h"
#import "WeChatSSO.h"
#import "TXWeiboUtil.h"
//#import "ROUserResponseItem.h"
//#import "ROPublishPhotoResponseItem.h"
//#import "MacroDefinition.h"
//#import "BoyaaUserView.h"

typedef enum
{
    Login_Nil           =    0,         //清空
    Login_Guest         =    1,         //游客登录
    Login_FaceBook      =    2,         //书脸 （这个压根就没有，为了统一lua的定义）
    Login_Sina          =    3,         //新浪登录
    Login_QQ            =    4,         //QQ登录
    Login_WeChat        =    5,         //微信登录
    Login_RenRen        =    6,         //人人登录
    Login_BoYaa         =    7,         //博雅登录
}LoginType;

@interface LoginManager : NSObject<WeChatSSODelegate,TencentSessionDelegate,QQApiInterfaceDelegate>

+(LoginManager*)sharedLoginManager;
-(void)userLoginWithType:(LoginType)loginType;
-(void)userLogoutWithType:(LoginType)loginType;
+ (BOOL)handleOpenURL:(NSURL *)url;  //第三方登陆跳转回调
-(void)resetThirdPartyLoginWithType:(LoginType)loginType errorCode:(int)errorCode;  //重置登录信息

@property(nonatomic, retain)TencentOAuth * txConnectOAuth;



// renren
//- (void)renrenLogout;

@end
