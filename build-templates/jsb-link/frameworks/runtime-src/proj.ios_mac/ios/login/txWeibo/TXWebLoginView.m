//
//  TXWebLoginView.m
//  Poker
//
//  Created by Wang Leitai on 1/16/14.
//
//

#import "TXWebLoginView.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation TXWebLoginView

@synthesize webview;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc
{

}

- (void)startLoadingView
{
    loadingLabel.text = NSLocalizedString(@"加载中. . .", nil);
    loadingLabel.hidden = NO;
    activityView.hidden = NO;
    [activityView startAnimating];
}

- (void)stopLoadingView
{
    [activityView stopAnimating];
    activityView.hidden = YES;
    loadingLabel.hidden = YES;
}

- (void)requestTXAuth
{
    [self startLoadingView];
    
    if (nil == webview) {
        webview = [[CustomWebView alloc] initWithFrame:self.frame];
        webview.backgroundColor = [UIColor darkGrayColor];
        webview.delegate = self;
        webview.scalesPageToFit = YES;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"https://graph.z.qq.com/moc2/authorize?response_type=token&client_id=%@&redirect_uri=&scope=get_simple_userinfo,upload_pic,add_share,add_topic,add_pic_t",myAppID];
    
    NSURLRequest *urlrequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [webview loadRequest:urlrequest];
}

- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (void)didGotAuthrizedInfo:(NSString *)tokenStr {
    NSDictionary *querysDic = [self dictionaryFromQuery:tokenStr usingEncoding:NSUTF8StringEncoding];
    NSString *openidURLStr = [NSString stringWithFormat:@"https://graph.qq.com/oauth2.0/me?access_token=%@",[querysDic objectForKey:@"#access_token"]];
    NSString *openidStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:openidURLStr] encoding:NSUTF8StringEncoding error:nil];
    openidStr = [[openidStr stringByReplacingOccurrencesOfString:@"callback(" withString:@""] stringByReplacingOccurrencesOfString:@");" withString:@""];
    NSDictionary *openidDic = [NSJSONSerialization JSONObjectWithData:[openidStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if (openidDic && [openidDic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [querysDic objectForKey:@"#access_token"],@"access_token",
                             [querysDic objectForKey:@"expires_in"],@"expires_in",
                             [openidDic objectForKey:@"openid"],@"open_id", nil];
        [self.delegate TXUserAuthorizeSuccessed:dic];
        [webview removeFromSuperview];
        [self stopLoadingView];
    }
}
#pragma mark webviewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"shouldStartLoadURL: %@",urlString);
    if ([urlString hasPrefix:@"http://open.z.qq.com/moc2/success.jsp"]) {
        /*
         成功
         http://open.z.qq.com/moc2/success.jsp?g_ut=2&#access_token=600F1FCC4369AEC3E0DF13E978203A2F&expires_in=7776000&state=
         失败，取消
         http://open.z.qq.com/moc2/success.jsp?g_ut=2&#usercancel=1&state=
         */
        NSRange range = [urlString rangeOfString:@"usercancel"];
        if (range.location && range.length) {
            [self.delegate TXUserAuthorizeFailed:YES];
        }else{
            [self didGotAuthrizedInfo:urlString];
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopLoadingView];
    if (self != [webview superview]) {
        [self insertSubview:webview belowSubview:cancelButton];

    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([error code] == NSURLErrorNotConnectedToInternet || [error code] == NSURLErrorNetworkConnectionLost) {
        [webview removeFromSuperview];
        [self stopLoadingView];
    }
}


@end
