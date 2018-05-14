//
//  GuestLoginData.m
//  Poker
//
//  Created by hudaoting on 13-11-29.
//  Copyright (c) 2013年 Boyaa iPhone Texas Poker. All rights reserved.
//

#import "GuestLoginData.h"

@implementation GuestLoginData


+(void)saveDataToDefault:(id)data forkey:(NSString*)key;
{
#ifdef ISIPAD
    if(data == nil || ![self checkData:data])
    {
        return;
    }
#else
    if(data == nil)
    {
        return;
    }
#endif
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:data forKey:[NSString stringWithFormat:@"%@%@", BUNDLE_ID,key]];
    [userDefault synchronize];
}

+(id)loadDataFromDefault:(NSString*)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *datakey = [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key];
    id resultData = [userDefault valueForKey:datakey];
    return resultData;
}

+ (void)saveDataToKeyChain:(id)data forkey:(NSString *)key
{
#ifdef ISIPAD
    if(data == nil || ![self checkData:data])
    {
        return;
    }
#else
    if(data == nil)
    {
        return;
    }
#endif
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    //删除keychain以前的存储
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //把数据存到keychain
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    if(status == noErr)
    {
        if(status == errSecSuccess)
        {
            NSLog(@"Save to keyChain success");
        }
        else{
            NSLog(@"Save to keyChain Failed");
        }
    }
    else{
        NSLog(@"Save to keyChain Failed");
    }
}

+ (id)loadDataFromKeyChain:(NSString*)key
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    //获取keychain中存的东西
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
    if (status == noErr) {
        if(status == errSecSuccess){
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        else{
            NSLog(@"status error type = %d",(int)status);
        }
    }
    if (keyData != nil)
    {
        CFRelease(keyData);
    }
    return ret;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString*)key
{
    NSMutableDictionary *dict = nil;
#ifdef ISIPAD
    dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key], (__bridge id)kSecAttrService,
            [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key], (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,(__bridge id)kSecAttrAccessible,
            nil];
#else
    dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key], (__bridge id)kSecAttrService,
            [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key], (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleWhenUnlocked,(__bridge id)kSecAttrAccessible,
            nil];
#endif
    return dict;
}

+ (void)saveDataToPasteboard:(id)data forkey:(NSString*)key;
{
#ifdef ISIPAD
    if(data == nil || ![self checkData:data])
    {
        return;
    }
#else
    if(data == nil)
    {
        return;
    }
#endif
    NSString *ptype = [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key];
    UIPasteboard* pboard = [UIPasteboard pasteboardWithName:[NSString stringWithFormat:@"%@%@", BUNDLE_ID,BY_GUEST_GUID_PASTE_BOARD] create:YES];
    [pboard setPersistent:YES];
    [pboard setData:[NSKeyedArchiver archivedDataWithRootObject:data] forPasteboardType:ptype];
    
    [self saveDataToPublicPasteboard:data forkey:key];
}
//保存到公共粘贴板
+ (void)saveDataToPublicPasteboard:(id)data forkey:(NSString*)key;
{
    if(data == nil || ![self checkData:data])
    {
        return;
    }
    NSString *ptype = [NSString stringWithFormat:@"%@", KEYCHAINKEY];
    UIPasteboard* pboard = [UIPasteboard generalPasteboard];
    [pboard setPersistent:YES];
    
    id saveData = [NSMutableDictionary dictionary];
    id nowData = [self loadDataFromPublicPasteboard];
    if (nowData && [nowData isKindOfClass:[NSDictionary class]]) {
        saveData = [NSMutableDictionary dictionaryWithDictionary:nowData];
    }
    [saveData setObject:data forKey:key];
    [pboard setData:[NSKeyedArchiver archivedDataWithRootObject:saveData] forPasteboardType:ptype];
}
+ (id)loadDataFromPasteboard:(NSString*)key
{
    UIPasteboard* pboard = [UIPasteboard pasteboardWithName:[NSString stringWithFormat:@"%@%@", BUNDLE_ID,BY_GUEST_GUID_PASTE_BOARD] create:YES];
    [pboard setPersistent:YES];
    NSString *ptype = [NSString stringWithFormat:@"%@%@", BUNDLE_ID,key];
    id data = [pboard dataForPasteboardType:ptype];
    id resultData = nil;
    if(data != nil)
    {
        resultData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!resultData) {
        resultData = [self loadDataFromPublicPasteboard:key];
    }
    return resultData;
}
//到公共粘贴板度数据
+ (id)loadDataFromPublicPasteboard:(NSString*)key
{
    
    id data = [self loadDataFromPublicPasteboard];
    id resultData = nil;
    if(data != nil && [data isKindOfClass:[NSDictionary class]])
    {
        resultData = [(NSDictionary *)data objectForKey:key];
    }
    return resultData;
}
+ (id)loadDataFromPublicPasteboard
{
    UIPasteboard* pboard = [UIPasteboard generalPasteboard];
    [pboard setPersistent:YES];
    NSString *ptype = [NSString stringWithFormat:@"%@", KEYCHAINKEY];
    id data = [pboard dataForPasteboardType:ptype];
    id resultData = nil;
    if(data != nil)
    {
        resultData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return resultData;
}


+(void)saveDataToAllCanSavePlaceWith:(id)data forkey:(NSString*)key
{
    //先存keychain
    [self saveDataToKeyChain:data forkey:key];
    //存 userdeault
    [self saveDataToDefault:data forkey:key];
    
    //存 剪贴版
    [self saveDataToPasteboard:data forkey:key];
}
+(id)loadDataFromAllCanSavePlace:(NSString *)key
{
    id defaultData = [self loadDataFromDefault:key];
    BOOL isNotNil = false;
#ifdef ISIPAD
    isNotNil = defaultData != nil && [self checkData:defaultData];
#else
    isNotNil = defaultData != nil;
#endif
    
    if(isNotNil)
    {
        return defaultData;
    }
    else
    {
        id keychainData = [self loadDataFromKeyChain:key];
        if(keychainData != nil)
        {
            
            [self saveDataToDefault:keychainData forkey:key];
            [self saveDataToPasteboard:keychainData forkey:key];
            return keychainData;
        }
        else
        {
            id PboardData = [self loadDataFromPasteboard:key];
            isNotNil = false;
#ifdef ISIPAD
            isNotNil = PboardData != nil && [self checkData:PboardData];
#else
            isNotNil = PboardData != nil;
#endif
            
            if(isNotNil)
            {
                [self saveDataToDefault:PboardData forkey:key];
                [self saveDataToKeyChain:PboardData forkey:key];
                return PboardData;
            }
            else
            {
                return @"";
            }
        }
    }
}
+(BOOL)checkData:(id)data
{
    if(data != nil)
    {
        if ([data isKindOfClass:[NSString class]])
        {
            if ([(NSString*)data length]>0) {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    return false;
}

@end
