//
//  MMUtility.m
//  MMBaseUtility
//
//  Created by yzkmac on 2020/4/27.
//

#import "MMUtility.h"
#import <UIKit/UIKit.h>

@implementation MMUtility

//获取设备UUID
+ (NSString *)generateShortUUID
{
    NSString *result = [[NSUUID UUID] UUIDString];
    NSString *subResult = [result substringFromIndex:([result length] - 16)];
    return subResult;
}

+ (NSString *)generateUUID
{
    NSString *result = [[NSUUID UUID] UUIDString];
    return result;
}




+ (void)postNotificationToMainThreadName:(NSString *)name
{
    [self postNotificationToMainThreadName:name object:nil userInfo:nil];
}

+ (void)postNotificationToMainThreadName:(NSString *)name userInfo:(nullable NSDictionary *)userInfo
{
    [self postNotificationToMainThreadName:name object:nil userInfo:userInfo];
}

+ (void)postNotificationToMainThreadName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo
{
    if ([[NSThread currentThread] isMainThread]) {//当前是主线程直接post
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
    } else {// 当前线程不是主线程时在主线程中抛出
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
        });
    }
}



+ (void)handleApplicationOpenUrl:(NSURL *)url
{
    [self handleApplicationOpenUrl:url completionHandler:NULL];
}
+ (void)handleApplicationOpenUrl:(NSURL *)url completionHandler:(void (^ __nullable)(BOOL success))completion
{
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:completion];
}
+ (void)handleApplicationOpenUrlString:(NSString *)appURL
{
    return [self handleApplicationOpenUrl:[NSURL URLWithString:appURL]];
}


//这个方法实际是用来判断是否越狱的，为了避免被hacker查找到，使用别的方法名字。
//此方法真正的名字应该是 isJailBroken
+ (BOOL)didChangeUserStatus
{
    static BOOL status = NO;
#if !(TARGET_IPHONE_SIMULATOR)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
            status = YES;
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
            status = YES;
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]) {
            status = YES;
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]) {
            status = YES;
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]) {
            status = YES;
        }
        
        //如果status=YES, 也就没必要继续验证了
        if (!status) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
                //Device is jailbroken
                status = YES;
            }
        }
    });
#endif
    return status;
}

@end
