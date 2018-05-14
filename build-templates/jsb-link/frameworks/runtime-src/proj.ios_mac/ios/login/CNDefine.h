//
//  CNDefine.h
//  Poker
//
//  Created by tan on 11-12-22.
//  Copyright (c) 2011年 Boyaa iPhone Texas Poker. All rights reserved.
//

#ifndef Poker_CNDefine_h
#define Poker_CNDefine_h

#define SD_CUR_VER              25
#define SINA_SID                117
#define RENREN_SID              1
#define TXWEIBO_SID             93
#define WECHAT_SID             355
#define UNID                    140
#define SD_CUR_VER_DESC			@"iPhoneCN"

#define SD_PROGRAME_VERSION		@"5.5.0"    //当前程序版本(必须和Poker-Info.plist中的版本保持一致)program version

#define kHttpAuthXKey           @"1oBqjxWg27A78QDIznaUbQ=="		//服务器:o4d5f8SBmgNeynBM7bNxEA==			//sina版

//停服时判断要不要去取XML文件 国内要先ping的域名 国内定的是baidu
#define STOP_SERVER_SERVICE_PING_DNS  @"http://www.baidu.com"

//获取上次登陆服务器
#define GetLastLoginServer() [[[NSUserDefaults standardUserDefaults] objectForKey:@"LastLoginServer"] intValue]

//存储本次登陆服务器
#define SetLastLoginServer(sid) {\
[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:sid] forKey:@"LastLoginServer"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#ifdef LOCAL_MODE
#define Notify_ADD_IPHONETEXAS @"http://local146.boyaa.com/texas/api/PushNotify.php"
#else
#define Notify_ADD_IPHONETEXAS @"http://iphone-poker-cn.boyaa.com/api/PushNotify.php"
#endif

// 小喇叭内网
#define  TXHallSocketDemo @[@"192.168.103.122", @"9810"]
#define  HallSocketDemo @[@"192.168.103.122", @"9840"]
#define  HallSocketNo3  @[@"120.132.147.4", @"6200"]
#define  HallSocket146  @[@"192.168.100.146", @"6202"]
//小喇叭 正式 为空代表从 xml表下载。
#define  HallSocketProduct @""

//-------------------------博雅通行证-----------------------------------
#define  BOYAA_CENTER_APPKEY            @"1362118090"
#define  BOYAA_CENTER_APPSCERECT        @"pkr123!@#ma9_=a*hs9103!=t#kx1=a0"
#define  BOYAA_CENTER_APPNAME           @"扑克"
#define  BOYAA_CENTER_APPLOGO_ADDR      @"http://usspuc01.static.17c.cn/icon/app/poker.jpg"
//模拟正式　类似于业务服务器的NO３
//@"http://usspuc01.ifere.com/h5/zh_CN/"
//１３４测试环境
//@"http://192.168.100.134/h5/zh_CN/index.html"

#define FINDBACK_GUEST_ADDRESS  @"http://iphone-poker-cn.boyaa.com/api/gback.php?si=fa0ce81c3c5c3a9b&lc=zh"
//正式环境
#define  BOYAA_CENTER_APPUSER_ADDR  @"http://id.boyaa.com/h5/zh_CN/"
#define  BOYAA_CENTER_APPGAMEVERSION    SD_PROGRAME_VERSION

//------------------------法律条款和隐私政策URL----------------------------
#define Privacy_Policy_URL  @"http://www.b.com/mobile/PrivacyPolicy1.html"
#define Serverce_Policy_URL  @"http://www.b.com/mobile/termsofservice1.html"
#define ALGORITHM_JUST_URL  @"http://pkws117.17c.cn/mobile/impartial.html"
//------------------------- Apple --------------------------------------
#ifdef ISIPAD
#define APPLE_ITUNES_ID         @"500013575"
#else

#ifdef ISDOUPAI
#define APPLE_ITUNES_ID         @"49093913555"
#else
#define APPLE_ITUNES_ID         @"1249967854"
#endif

#endif

//------------------------- 电话号码 --------------------------------------
#define TELPHONENUM         @"Tel:4008"
//------------------------- Else ------------------------------------------

#define TapjoyAppID             @"6b583481-b13d-41c7-8f04-aa91dd16fb11"
#define TapjoyAppKey            @"NIM04a0d8HNHTWRi5M6F"

//Crittericism
#define Crittercism_APPID       @"4ffe9162eeaf415dfc00000d"
#define Crittercism_Key         @"nyxd4obmpkdriw8lc1jev5pgetyr"
#define Crittercism_Secret      @"z6jtz0qhb549ovpfaagr2styc8d1nhex"

//AdMob
#define AdMob_ITUNESID          APPLE_ITUNES_ID

//Flurry数据统计
//#define FLURRY_KEY              @"2YD27R4M94276L7XXEHK"

//iPhone分享Feed链接
#define kFeedUrl                @"http://poker.boyaagame.com/adp/apps/sms.php?n=2012"
#define kShareIconUrl           @"http://pkws117.17c.cn/images/gamepic1.jpg"
#define kShortFeedUrl           @"http://dwz.cn/1J5pnD"
#define  CustomerService          @"kefu@boyaa.com"
#define  CustomerTel              @"400-663-1888"

//-------------------------语音服务器ID和地址---------------------------
#define BC_PHP_SERVER_HOST @"http://pk2000101.17c.cn:8000"
//#define BC_GAME_ID 0x1003
//-------------------------语音服务器地址和应用ID---------------------------
//是否支持语音
#define HAS_BOYAA_CHAT

#define ProtoBuffer             1 //

//支持PHPServer的V8接口，1代表版本号
#define PHP_API_V8              1

//是否自己实现IAP支付。
#define IS_SELF_IAP

//是否支持打渠道包
#define IS_SUPPORT_CHANNEL_APP

//对应iPhone的本地跳转URL 必须与plist中的设置对应
#ifdef ISIPAD
#define LOCALSCHEME         @"pokercn"
#else
#define LOCALSCHEME         @"pokercnhd"
#endif

#endif
