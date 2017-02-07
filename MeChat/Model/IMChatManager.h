//
//  IMChatManager.h
//  MeChat
//
//  Created by cimimorio on 2017/2/7.
//  Copyright © 2017年 yuxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK.h>

NSString *kAppKey = @"9a0c90be6dd11164ecead8498af94af3";
NSString *kCerName = @"chat";


typedef void(^IMLogHandler)(NSError * error);

@interface IMChatManager : NSObject

+ (instancetype)shareManager;

#pragma mark --
#pragma mark --login and logout

//手动登陆
- (void)mLoginWithAccount:(NSString *)accout andToken:(NSString *)token completion:(IMLogHandler)completion;

- (void)logout:(IMLogHandler)completion;

#pragma mark --
#pragma mark -- send massage

//文字消息
- (void)sendTextMassage:(NSString *)massegeString toUser:(NSString *)userID;

//图片消息
- (void)sendImageMassege:(NSString *)imagePath toUser:(NSString *)userID;

//音频消息
- (void)sendAudioMassege:(NSString *)audioMassege toUser:(NSString *)userID;

//视屏消息
- (void)sendVideoMassege:(NSString *)videoPath toUser:(NSString *)userID;

//地理消息
- (void)sendLocationMassegeWithLatitude:(double)latitude Longitude:(double)longitude addressTitle:(NSString *)title toUser:(NSString *)userID;

//提醒消息
- (void)sendTipsMassageToUser:(NSString *)userID;

//自定义消息
- (void)sendCusMassage:(id)massage toUser:(NSString *)userID;

@end
