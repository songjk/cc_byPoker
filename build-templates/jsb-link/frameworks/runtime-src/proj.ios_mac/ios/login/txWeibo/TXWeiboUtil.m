//
//  TXWeiboUtil.m
//  Poker
//
//  Created by Zhulin on 12-8-29.
//  Copyright (c) 2012年 Boyaa iPhone Texas Poker. All rights reserved.
//

#import "TXWeiboUtil.h"
#import "SFHFKeychainUtils.h"
#import "KeyChainDefine.h"
#import "utility.h"
#import "TXWebLoginView.h"

@implementation TXWeiboAuthParam

@synthesize accessToken, openid, expireIn;

- (NSString*)description
{
    NSString *dec = [super description];
    return [NSString stringWithFormat:@"%@ accessToken:%@, openid:%@, expireIn:%@", dec, accessToken, openid, expireIn];
}

@end

@implementation TXWeiboUtil

+ (void)saveAuthParam:(TXWeiboAuthParam*)param
{
    if ([[self class] isValidParam:param]) {
        [SFHFKeychainUtils storeUsername:TXWeiboAccessToken
                             andPassword:param.accessToken
                          forServiceName:XAuthServiceName
                          updateExisting:YES
                                   error:nil];
        [SFHFKeychainUtils storeUsername:TXWeiboOpenid
                             andPassword:param.openid
                          forServiceName:XAuthServiceName
                          updateExisting:YES
                                   error:nil];
        [SFHFKeychainUtils storeUsername:TXWeiboExpireIn
                             andPassword:param.expireIn
                          forServiceName:XAuthServiceName
                          updateExisting:YES
                                   error:nil];
    }
}

+ (TXWeiboAuthParam*)loadAuthParam
{
//    __autoreleasing TXWeiboAuthParam *param = [[TXWeiboAuthParam alloc] init];
    TXWeiboAuthParam *param = [[TXWeiboAuthParam alloc] init];
    param.accessToken = [SFHFKeychainUtils getPasswordForUsername:TXWeiboAccessToken
                                                   andServiceName:XAuthServiceName
                                                            error:nil];
    param.openid = [SFHFKeychainUtils getPasswordForUsername:TXWeiboOpenid
                                              andServiceName:XAuthServiceName
                                                       error:nil];
    param.expireIn = [SFHFKeychainUtils getPasswordForUsername:TXWeiboExpireIn
                                                andServiceName:XAuthServiceName
                                                         error:nil];
    return param;
}


+ (void)removeAuthParam
{
    [SFHFKeychainUtils deleteItemForUsername:TXWeiboAccessToken
                              andServiceName:XAuthServiceName
                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:TXWeiboOpenid
                              andServiceName:XAuthServiceName
                                       error:nil];
    [SFHFKeychainUtils deleteItemForUsername:TXWeiboExpireIn
                              andServiceName:XAuthServiceName
                                       error:nil];
}

+ (BOOL)isValidParam:(TXWeiboAuthParam*)param
{
    BOOL flag = NO;
    if(param != nil && [param isKindOfClass:[TXWeiboAuthParam class]])
    {
        //目前只检查accessToken与Openid
        if (IsNoEmptyString(param.accessToken) && IsNoEmptyString(param.openid)) {
            flag = YES;
        }
    }
    return flag;
}

@end

@implementation TXOAuthObject

+(TXOAuthObject *)shareTecentOAuth{
    static TXOAuthObject *singleton=nil;
	@synchronized(self){
		if(singleton == nil){
            singleton = [[[self class] alloc] init];
            singleton.tencentOAuth = [[TencentOAuth alloc] initWithAppId:myAppID andDelegate:nil];
        }
	}
	return singleton;
}

@end
