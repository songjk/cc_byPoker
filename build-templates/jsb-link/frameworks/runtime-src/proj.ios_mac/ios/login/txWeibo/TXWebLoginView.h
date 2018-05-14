//
//  TXWebLoginView.h
//  Poker
//
//  Created by Wang Leitai on 1/16/14.
//
//

#import <UIKit/UIKit.h>
//#import "JSONKit.h"
#import "CustomWebView.h"
#ifdef ISIPAD
#define myAppID    @"23006"
#else
#define myAppID    @"1150003730"
#endif
@protocol TXWebLoginViewDelegate <NSObject>

- (void)TXUserAuthorizeSuccessed:(NSDictionary *)userInfo;
- (void)TXUserAuthorizeFailed:(BOOL)isUserCancel;

@end

@interface TXWebLoginView : UIView<UIWebViewDelegate>
{
    CustomWebView *webview;
    UIActivityIndicatorView *activityView;
    UIButton  *cancelButton;
    UILabel *loadingLabel;
    //id<TXWebLoginViewDelegate> delegate;
}

@property(nonatomic,retain)CustomWebView *webview;
@property(nonatomic,assign)id<TXWebLoginViewDelegate> delegate;

- (void)requestTXAuth;

@end
