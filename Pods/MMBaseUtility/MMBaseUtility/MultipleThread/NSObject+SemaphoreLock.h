//
//  NSObject+SemaphoreLock.h
//  MomoChat
//
//  Created by song.meng on 2021/6/16.
//  Copyright © 2021 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MMNSObjectThreadBlockedNotification; // 线程blocked通知，不一定在主线程发送

@interface NSObject (SemaphoreLock)

/// 初始化锁
/// 锁可通过懒加载方式初始化，多线程情况下懒加载可能出现一些意想不到的问题
- (void)initSemaphoreLock;
/// 初始化锁
/// 锁可通过懒加载方式初始化，多线程情况下懒加载可能出现一些意想不到的问题
/// @param identfire 唯一标记，当出现疑似线程死锁时警告或通知提示，方便问题排查，建议通过此方法设置，可采取@"class.varName"的形式
- (void)initSemaphoreLockWithIdentifire:(NSString *)identfire;


/// action在信号量互斥中执行，超时时间为20s，若超时认为线程存在死锁风险，开发测试环境下弹窗提示
/// 等待超时不执行action
/// action为nil时不执行任何操作
/// @param action 任务块
- (void)threadSafeSyncAction:(dispatch_block_t)action;


/// action在信号量互斥中执行，等待时间由interval指定，若超时时间大于20且等待超时则认为线程存在死锁风险，开发测试环境下弹窗提示
/// 等待超时不执行action
/// @param action 任务块
/// @param interval 等待时长，单位：秒
/// @return 0表示正常获得锁，否则为timeout
- (intptr_t)threadSafeSyncAction:(dispatch_block_t)action timeOut:(NSTimeInterval)interval;


@end

NS_ASSUME_NONNULL_END
