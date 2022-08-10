//
//  MDSourceTimer.h
//  MomoChat
//
//  Created by Allen on 3/25/16.
//  Copyright © 2016 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 使用dispatch_source_t实现的timer，不会显式的retain timer的target，可以指定dispatch_source_t的queue，如果不指定默认会使用系统的dispatch_global_queue
 */

typedef NS_ENUM(NSUInteger, MDSourceTimerMode)
{
    MDSourceTimerModeRunWhileApplicationActive  = 0,//相对时间，受设备休眠影响
    MDSourceTimerModeAlwaysRun                  = 1 //绝对时间，不受设备休眠影响
};

@interface MDSourceTimer : NSObject

/// 快速初始化一个基于dispatch_source_t的timer，调用完这个方法这个timer就开始run了
/// @param interval timer触发的间隔
/// @param targetQueue 指定dispatch_source_t所在的queue，timer触发之后的回调也在这个queue中，如果不指定
/// @param target timer触发时需要接收selector回调的target
/// @param selector timer触发时回调的selector
/// @param userInfo timer回调时需要关心的一些信息
/// @param yesOrNo timer的触发是否重复
+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval targetQueue:(nullable dispatch_queue_t)targetQueue target:(id)target selector:(SEL)selector userInfo:(nullable id)userInfo repeat:(BOOL)yesOrNo;


/// 快速初始化一个基于dispatch_source_t的timer，调用完这个方法这个timer就开始run了，这个timer会绑定在global queue中
/// @param ti timer触发的间隔
/// @param aTarget timer触发时需要接收selector回调的target
/// @param aSelector timer触发时回调的selector
/// @param userInfo timer回调时需要关心的一些信息
/// @param yesOrNo timer的触发是否重复

+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;


/// 基于block回调方式的dispatch_source_t的timer，调用完这个方法timer就run了
/// @param ti timer触发的间隔
/// @param targetQueue 指定dispatch_source_t所在的queue，timer触发之后的回调也在这个queue中
/// @param yesOrNo timer是否需要重复触发
/// @param block timer触发时执行的block
+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti targetQueue:(nullable dispatch_queue_t)targetQueue repeat:(BOOL)yesOrNo block:(void (^)(MDSourceTimer *timer))block;


/// 基于block回调方式的dispatch_source_t的timer，调用完这个方法timer就run了
/// @param ti timer触发的间隔
/// @param targetQueue  指定dispatch_source_t所在的queue，timer触发之后的回调也在这个queue中
/// @param mode 指定timer触发的mode，默认为MDSourceTimerModeRunWhileApplicationActive，这个参数指定timer是否受设备休眠影响。相对时间和绝对时间的区别
/// @param leeway timer触发时在interval基础上容忍的误差，系统可以基于这个值做一些事件合并，性能会更好一些
/// @param yesOrNo timer是否重复触发
/// @param block timer触发时执行的block
+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti targetQueue:(nullable dispatch_queue_t)targetQueue timerMode:(MDSourceTimerMode)mode nanoSecondsOfLeeway:(NSInteger)leeway repeat:(BOOL)yesOrNo  block:(void (^)(MDSourceTimer *timer))block;


/// 快速初始化一个基于dispatch_source_t的timer，调用完这个方法之后timer并不会run，需要显式的调用fire方法之后timer才会run
/// @param interval timer触发的间隔
/// @param targetQueue 指定dispatch_source_t所在的queue，timer触发之后的回调也在这个queue中，如果不指定
/// @param target timer触发时需要接收selector回调的target
/// @param selector timer触发时回调的selector
/// @param userInfo timer回调时需要关心的一些信息
/// @param yesOrNo timer的触发是否重复
- (instancetype)initWithTimeInterval:(NSTimeInterval)interval targetQueue:(nullable dispatch_queue_t)targetQueue target:(nullable id)target selector:(nullable SEL)selector userInfo:(nullable id)userInfo repeat:(BOOL)yesOrNo;


/// 设置的关联timer的userInfo
@property (nullable, readonly, strong) id            userInfo;

/// 误差容忍时间，单位纳秒，默认为0。注意即使为0，也会有误差时间
@property (nonatomic, assign) NSInteger              nanoSecondsOfLeeway;

/// timer触发的间隔
@property (readonly) NSTimeInterval                  timeInterval;

/// default mode is MDSourceTimerModeRunWhenApplicationActive，timer run起来之后再设置就不会有效果了
@property (nonatomic, assign) MDSourceTimerMode      timerMode;

/// 计时器是否有效
@property (readonly, getter=isValid)BOOL             valid;

//将当前timer置成失效
- (void)invalidate;

/// 启动定时器
- (void)fire;

// 从当前开始计时，延迟到下一个间隔执行
- (void)delay;

@end

NS_ASSUME_NONNULL_END
