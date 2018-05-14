//
//  nativeOcClass.m
//  cc_byPoker-mobile
//
//  Created by mac on 2018/5/14.
//

#import "nativeOcClass.h"

@implementation nativeOcClass
+(void)showAlertView:(NSString *)msg
{
    UIApplication *app = [UIApplication sharedApplication];
    UIViewController* root = app.keyWindow.rootViewController;
    NSString * str = [NSString stringWithFormat:@"%@", msg];
    UIAlertController * av = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action  = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [av addAction:action];
    [root presentViewController:av animated:true completion:nil];
}

+(void)loginWithType:(NSString *)type
{
    LoginType loginType = [type intValue];
    [[LoginManager sharedLoginManager] userLoginWithType:loginType];
}
@end
