//
//  IMChatManager.m
//  MeChat
//
//  Created by cimimorio on 2017/2/7.
//  Copyright © 2017年 yuxiao. All rights reserved.
//

#import "IMChatManager.h"

@interface IMChatManager ()<NIMLoginManagerDelegate,NIMChatManagerDelegate>

@property (strong,nonatomic) NIMSDK *nimSDK;

@end

@implementation IMChatManager

+(instancetype)shareManager{
    
    static IMChatManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[IMChatManager alloc] init];
    });
    return manager;
}

#pragma mark --
#pragma mark -- 初始化

- (instancetype)init{
    
    if (self = [super init]) {
        self.nimSDK = [NIMSDK sharedSDK];
        [self.nimSDK registerWithAppID:kAppKey cerName:kCerName];
        [[self.nimSDK loginManager] addDelegate:self];
        [[self.nimSDK chatManager] addDelegate:self];
    }
    return self;
}

#pragma mark --
#pragma mark -- login and logout
//手动登陆
- (void)mLoginWithAccount:(NSString *)accout andToken:(NSString *)token completion:(IMLogHandler)completion{
    [[self.nimSDK loginManager] login:accout token:token completion:^(NSError * _Nullable error) {
        if (error) {
            completion(error);
        }else{
            completion(nil);
        }
    }];
}

#pragma mark --logout

- (void)logout:(IMLogHandler)completion{
    [[self.nimSDK loginManager] logout:^(NSError * _Nullable error) {
        if (error) {
            completion(error);
        }else{
            completion(nil);
        }
    }];
}

#pragma mark --
#pragma mark -- send massage

//文字消息
- (void)sendTextMassage:(NSString *)massegeString toUser:(NSString *)userID{
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text = massegeString;
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    NSError *error = nil;
    [[self.nimSDK chatManager] sendMessage:message toSession:session error:&error];
    if (error) {
        NSLog(@"text message send to %@ fail error:%@",userID,error);
    }else{
        NSLog(@"text message send to %@ succec",userID);
    }
}

//图片消息
- (void)sendImageMassege:(NSString *)imagePath toUser:(NSString *)userID{
    NIMImageObject *imgObj = [[NIMImageObject alloc] initWithFilepath:imagePath];
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = imgObj;
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    NSError *error = nil;
    [[self.nimSDK chatManager] sendMessage:message toSession:session error:&error];
    if (error) {
        NSLog(@"image message send to %@ fail error:%@",userID,error);
    }else{
        NSLog(@"image message send to %@ succec",userID);
    }
}

//音频消息
- (void)sendAudioMassege:(NSString *)audioMassege toUser:(NSString *)userID{
    NIMAudioObject *auObj = [[NIMAudioObject alloc] initWithSourcePath:audioMassege];
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = auObj;
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    NSError *error = nil;
    [[self.nimSDK chatManager] sendMessage:message toSession:session error:&error];
    if (error) {
        NSLog(@"image message send to %@ fail error:%@",userID,error);
    }else{
        NSLog(@"image message send to %@ succec",userID);
    }
}

//视屏消息
- (void)sendVideoMassege:(NSString *)videoPath toUser:(NSString *)userID{
    NIMVideoObject *vidObj = [[NIMVideoObject alloc] initWithSourcePath:videoPath];
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = vidObj;
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    NSError *error = nil;
    [[self.nimSDK chatManager] sendMessage:message toSession:session error:&error];
    if (error) {
        NSLog(@"image message send to %@ fail error:%@",userID,error);
    }else{
        NSLog(@"image message send to %@ succec",userID);
    }
}

//地理消息
- (void)sendLocationMassegeWithLatitude:(double)latitude Longitude:(double)longitude addressTitle:(NSString *)title toUser:(NSString *)userID{
    NIMLocationObject *locObj = [[NIMLocationObject alloc] initWithLatitude:latitude longitude:longitude title:title];
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = locObj;
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    NSError *error = nil;
    [[self.nimSDK chatManager] sendMessage:message toSession:session error:&error];
    if (error) {
        NSLog(@"image message send to %@ fail error:%@",userID,error);
    }else{
        NSLog(@"image message send to %@ succec",userID);
    }
}

//提醒消息
- (void)sendTipsMassageToUser:(NSString *)userID{
    //构造消息
    NIMTipObject *tipObject = [[NIMTipObject alloc] init];
    NIMMessage *message     = [[NIMMessage alloc] init];
    message.messageObject   = tipObject;
    
    //构造会话
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    
    //发送消息
    [self.nimSDK.chatManager sendMessage:message toSession:session error:nil];
}

//自定义消息
- (void)sendCusMassage:(id)massage toUser:(NSString *)userID{
    //构造消息
    NIMCustomObject *customObject     = [[NIMCustomObject alloc] init];
//    customObject.attachment           = attachment;
    NIMMessage *message               = [[NIMMessage alloc] init];
    message.messageObject             = customObject;
    
    //构造会话
    NIMSession *session = [NIMSession session:userID type:NIMSessionTypeP2P];
    
    //发送消息
    [self.nimSDK.chatManager sendMessage:message toSession:session error:nil];
}

#pragma mark --
#pragma mark -- callback

#pragma mark -- login callback

- (void)onLogin:(NIMLoginStep)step{

}

//被踢回调
- (void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType{
    
}

//自动登陆失败回调
- (void)onAutoLoginFailed:(NSError *)error{

}

#pragma mark -- send message callback
//即将发送消息回调
- (void)willSendMessage:(NIMMessage *)message{
    
}

//消息发送进度回调（图片、视频，文字没有）
- (void)sendMessage:(NIMMessage *)message progress:(CGFloat)progress{
    NSLog(@"%f has been send",progress);
}

//消息发送完毕回调
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error{
    if (error) {
        NSLog(@"%@ send fail error %@",message.messageId,error);
    }else{
        NSLog(@"%@ send succes",message.messageId);
    }
}

#pragma mark -- receive message

- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    
}





@end
