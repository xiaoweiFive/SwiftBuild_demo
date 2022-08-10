//
//  MFTimer.h
//  MomoChat
//
//  Created by 晗晖 刘 on 12-9-24.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 创建一个计时器（gcd），计时器到时自动执行 aDelegate 的 didReceiveTimerMark 方法
 * aInterval -- 计时间隔
 * aDelegate --- 到时执行方法的对象
 * aRepeat   --- 计时器是否重复执行
 * - (void) delay; 推迟计时器，到下一个interval
 * - (void) cancel; 取消计时器
 */

@class MFTimer;
@protocol MFTimerDelegate <NSObject>
- (void)didReceiveTimerMark:(MFTimer *)sender;
@end

DEPRECATED_MSG_ATTRIBUTE("推荐使用 MDSourceTimer")
@interface MFTimer : NSObject

@property(nonatomic, strong) NSString *identifier;

// 创建一个计时器，计时器到时自动执行 aDelegate 的 didReceiveTimerMark 方法
+ (instancetype)timerWithInterval:(float)aInterval
                         delegate:(id<MFTimerDelegate>)aDelegate
                           repeat:(BOOL)aRepeat;

- (instancetype)initWithInterval:(float)aInterval
                        delegate:(id<MFTimerDelegate>)aDelegate
                          repeat:(BOOL)aRepeat;

+ (instancetype)timerWithInterval:(float)aInterval
                            delay:(float)delay
                         delegate:(id<MFTimerDelegate>)aDelegate
                           repeat:(BOOL)aRepeat
                      targetQueue:(dispatch_queue_t)queue;

- (instancetype)initWithInterval:(float)aInterval
                           delay:(float)delay
                        delegate:(id<MFTimerDelegate>)aDelegate
                          repeat:(BOOL)aRepeat
                     targetQueue:(dispatch_queue_t)queue;

- (void)cancel;
- (void)clearDelegateAndCancel;
- (void)delay;

@end


