//
//  MMUtility.h
//  MMBaseUtility
//
//  Created by yzkmac on 2020/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMUtility : NSObject

//获取设备UUID
+ (NSString *)generateShortUUID; // 后16位
+ (NSString *)generateUUID; //32位全

#pragma mark - 发送通知
+ (void)postNotificationToMainThreadName:(NSString *)name;
+ (void)postNotificationToMainThreadName:(NSString *)name userInfo:(nullable NSDictionary *)userInfo;
+ (void)postNotificationToMainThreadName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

#pragma mark - 应用跳转
+ (void)handleApplicationOpenUrl:(NSURL *)url;
+ (void)handleApplicationOpenUrl:(NSURL *)url completionHandler:(void (^ __nullable)(BOOL success))completion;
+ (void)handleApplicationOpenUrlString:(NSString *)appURL;

#pragma mark - 越狱判断
//这个方法实际是用来判断是否越狱的，为了避免被hacker查找到，使用别的方法名字。
//此方法真正的名字应该是 isJailBroken
+ (BOOL)didChangeUserStatus;

@end

NS_ASSUME_NONNULL_END
