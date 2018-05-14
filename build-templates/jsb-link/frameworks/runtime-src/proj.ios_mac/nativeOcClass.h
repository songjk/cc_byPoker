//
//  nativeOcClass.h
//  cc_byPoker-mobile
//
//  Created by mac on 2018/5/14.
//

#import <Foundation/Foundation.h>

#import "LoginManager.h"
@interface nativeOcClass : NSObject
+(void)showAlertView:(NSString*)msg;

+(void)loginWithType:(NSString *)type;
@end
