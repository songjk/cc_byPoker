//
//  TXWeiboUtil.h
//  Poker
//
//  Created by Zhulin on 12-8-29.
//  Copyright (c) 2012年 Boyaa iPhone Texas Poker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
// 将腾讯微博SDK替换为QQConnect modified by zhulin at 2012/11/15 11:09

@interface TXWeiboAuthParam : NSObject

@property (nonatomic, retain)NSString * accessToken;
@property (nonatomic, retain)NSString * openid;
@property (nonatomic, retain)NSString * expireIn;

@end

@interface TXWeiboUtil : NSObject

+ (void)saveAuthParam:(TXWeiboAuthParam*)param;
+ (TXWeiboAuthParam*)loadAuthParam;
+ (BOOL)isValidParam:(TXWeiboAuthParam*)param;
+ (void)removeAuthParam;

@end

@interface TXOAuthObject : NSObject
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
+(TXOAuthObject*)shareTecentOAuth;

@end