//
//  OCtoJS.m
//  cc_byPoker-mobile
//
//  Created by mac on 2018/5/15.
//
#import "cocos2d.h"
#import "OCtoJS.h"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
#import "JSONKit.h"
using namespace cocos2d;

@implementation OCtoJS


+(void)loginWechatWithToken:(NSString *)token openid:(NSString*)openid{
    
    // call the js function
    std::string strRet = [token UTF8String];
    std::string strOpenid = [openid UTF8String];
    std::string jsCallStr = cocos2d::StringUtils::format("loginWechat(\"%s\",\"%s\");", strRet.c_str(), strOpenid.c_str());
    se::Value *ret = new se::Value();
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str() , -1 , ret);
}

@end
