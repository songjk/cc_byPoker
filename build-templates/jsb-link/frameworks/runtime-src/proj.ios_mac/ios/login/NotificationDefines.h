/*
 *  NotificationDefines.h
 *  Poker
 *
 *  Created by Zhulin on 11-10-27.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef shareUserDefault
#define  shareUserDefault [NSUserDefaults standardUserDefaults]
#endif

#define kRoomStoreIsPayLimited      @"kRoomStoreIsPayLimited"

#define NoticeUserAuthorizeInfo         @"NoticeUserAuthorizeInfo"               //获取博雅通行证登录玩家授权信息
#define NoticeFacebookAuthorizeInfo     @"NoticeFacebookAuthorizeInfo"  //存储facebook绑定账户验证token，用于自动登录
#define NoticeBoyaaUserLoginInfo    @"NoticeBoyaaUserLoginInfo"  //博雅通行证自动登陆

#define RequestBindingBombOutRoomFinish   @"RequestBindingBombOutRoomFinish" //退出房间时获取绑定提示
#define NoticeBindingResult             @"NoticeBindingResult"        //绑定结束
#define NoticeLoginBindingResult             @"NoticeLoginBindingResult"        //绑定结束
#define NoticeBindingSuccessed          @"NoticeBindingSuccessed"     //绑定成功

#define kNoticeCNHsubviewDidremove     @"NoticeCNHsubviewDidremove"    //  大厅的弹窗消失了一个
#define kNoticeBoyaaCenterH5ViewClose  @"kNoticeBoyaaCenterH5ViewClose"
#define kNoticeFBAuthViewClose         @"kNoticeFBAuthViewClose"
#define kNoticeFBAuthRequestMyInfo     @"kNoticeFBAuthRequestMyInfo"
#define kNoticeSinaAuthViewClose        @"kNoticeSinaAuthViewClose"
#define NoticeLoginBindingViewClose             @"NoticeLoginBindingViewClose"        //关闭大厅绑定界面
//好友邀请
#define NoticeSendInviteFriendResult    @"NoticeSendInviteFriendResult" //邀请结果
#define NoticeSendInviteRespond         @"NoticeSendInviteRespond"      //接受邀请回应
#define NoticeReceivedInviteTips        @"NoticeReceivedInviteTips"     //收到邀请信息
#define NoticeWillEnterTheRoom          @"NoticeWillEnterTheRoom"       //进入指定房间ID
#define NoticeRecieveOffLineInvite          @"NoticeRecieveOffLineInvite"       //应用没关闭时受到离线邀请



#define kNoticeShareViewControllerDidCancel     @"NoticeShareViewControllerDidCancel"    // 分享点取消了
#define kNoticeShareViewControllerDidClickShare     @"NoticeShareViewControllerDidClickShare"    // 分享点取消了


//5.0 新手任务 有 任务完成 但未领取
#define kNoticeNHTASK_UNREWARD             @"kNoticeNHTASK_UNReward"


#define kNoticeShareViewControllerDidClickShare     @"NoticeShareViewControllerDidClickShare"    // 点击分享
#define kNoticeShareViewControllerShareSuccess     @"NoticeShareViewControllerShareSuccess"    // 分享成功
#define kNoticeShareViewControllerShareFaile     @"kNoticeShareViewControllerShareFaile"    // 分享失败
