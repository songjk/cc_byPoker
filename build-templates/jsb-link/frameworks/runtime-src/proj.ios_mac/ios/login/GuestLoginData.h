//
//  GuestLoginData.h
//  Poker
//
//  Created by hudaoting on 13-11-29.
//  Copyright (c) 2013年 Boyaa iPhone Texas Poker. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVERICE_NAME_KEY_GUID_DEMO    @".FnkdKJH06ijshBClmdsAj10DEMO"
#define SERVERICE_NAME_KEY_GUID         @".FnkdKJH06ijshBClmdsAj10"
#define BY_GUEST_GUID_PASTE_BOARD   @".GuestGuidPasteBoard"

#ifdef ISIPAD
#define BUNDLE_ID @"com.boyaa.texas"
#else
#define BUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#endif

#define KEYCHAINKEY @"boyaaPokerCN"



@interface GuestLoginData : NSObject

/*
 存取userDefault相关
 */
+(void)saveDataToDefault:(id)data forkey:(NSString*)key;
+(id)loadDataFromDefault:(NSString*)key;

/*
存取keyChain相关
 */
+ (void)saveDataToKeyChain:(id)data forkey:(NSString*)key;
+ (id)loadDataFromKeyChain:(NSString*)key;
+ (NSMutableDictionary *)getKeychainQuery:(NSString*)key;

/*
 存取剪贴版相关
 */
+ (void)saveDataToPasteboard:(id)data forkey:(NSString*)key;
+ (id)loadDataFromPasteboard:(NSString*)key;

/*
 存取userDefault keyChain 剪贴版相关
 */
+(void)saveDataToAllCanSavePlaceWith:(id)data forkey:(NSString*)key;
+(id)loadDataFromAllCanSavePlace:(NSString*)key;


@end
