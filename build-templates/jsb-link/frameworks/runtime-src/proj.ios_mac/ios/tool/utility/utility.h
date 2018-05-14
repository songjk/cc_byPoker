//
//  utility.h
//  Poker
//
//  Created by lijun on 10-9-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//获取当前登陆类型
#define GetLoginType() [[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentLoginType"] intValue]

//存储登陆类型
#define SetLoginType(loginType) {\
[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:loginType] forKey:@"CurrentLoginType"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//获取当前分享类型
#define GetShareType() [[[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentShareType"] intValue]

//存储登陆或分享类型
#define SetShareType(shareType) {\
[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:shareType] forKey:@"CurrentShareType"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//获取当前登陆或分享类型
#define GetLoginOrShareType() [[[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentLoginOrShareType"] intValue]

//存储分享类型
#define SetLoginOrShareType(type) {\
[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:type] forKey:@"CurrentLoginOrShareType"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define JellyanIPhoneToken  @"<63f717f4 a30b6e22 c902c983 9316820a 450e43fb 6d016a4a 04212512 45daf143>"
#define DeviceToken         JellyanIPhoneToken

//string检测
#define IsNoEmptyString(str) (str != nil && [str isKindOfClass:[NSString class]] && ([str length] > 0))


//iphone5适配相关
#define isIPhone5 ([UIScreen mainScreen].bounds.size.width ==568 || [UIScreen mainScreen].bounds.size.height ==568)

//iphone4相关
#define isIPhone4 ([UIScreen mainScreen].bounds.size.width ==480 || [UIScreen mainScreen].bounds.size.height ==480)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//只在调试状态下输出信息
#define TEXAS_PRELOG [NSString stringWithFormat:@"%s [%d] ", __PRETTY_FUNCTION__, __LINE__]
#ifdef DEBUG
#define DebugLog( param, ... ) do {\
                                NSLog((@"%@" param), TEXAS_PRELOG, ##__VA_ARGS__);\
                            } while (0)
#else
#define DebugLog( param, ... )
#endif


/*
 *  System Versioning Preprocessor Macros
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define screenHeight  (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define screenWidth   (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)



NSString *md5Encryption(NSString *str);
NSString *hashedISU(NSString *isu);
NSString * getFileMD5AtPath(NSString * path);

//International Version Setting
//延时执行一段block
@interface NSObject (DelayedBlock)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
//Setting end


