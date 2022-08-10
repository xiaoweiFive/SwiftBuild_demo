//
//  MFTimer.m
//  MomoChat
//
//  Created by 晗晖 刘 on 12-9-24.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "MFTimer.h"

@interface MFTimer ()

@property (nonatomic, assign) BOOL repeat;
@property (nonatomic, assign) float interval;

@property (nonatomic, weak) id<MFTimerDelegate> delegate;
@property (nonatomic, strong) dispatch_queue_t targetQueue;
@property (nonatomic, strong) dispatch_source_t innerTimer;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
@implementation MFTimer
#pragma clang diagnostic pop

@synthesize identifier, repeat, interval, targetQueue, delegate, innerTimer;

+ (id) timerWithInterval:(float)aInterval
                delegate:(id<MFTimerDelegate>)aDelegate
                  repeat:(BOOL)aRepeat
{
    return [[MFTimer alloc] initWithInterval:aInterval delegate:aDelegate repeat:aRepeat];
}

+ (id) timerWithInterval:(float)aInterval
                   delay:(float)delay
                delegate:(id<MFTimerDelegate>)aDelegate
                  repeat:(BOOL)aRepeat
             targetQueue:(dispatch_queue_t)queue
{
    return [[MFTimer alloc] initWithInterval:aInterval delay:delay delegate:aDelegate repeat:aRepeat targetQueue:queue];
}

- (id) initWithInterval:(float)aInterval
               delegate:(id<MFTimerDelegate>)aDelegate
                 repeat:(BOOL)aRepeat;
{
    return [self initWithInterval:aInterval delay:aInterval delegate:aDelegate repeat:aRepeat targetQueue:nil];
}

- (id) initWithInterval:(float)aInterval
                  delay:(float)delay
               delegate:(id<MFTimerDelegate>)aDelegate
                 repeat:(BOOL)aRepeat
            targetQueue:(dispatch_queue_t)queue
{
    self = [super init];
    if (self) {
        interval = aInterval;
        delegate = aDelegate;
        repeat = aRepeat;
        
        targetQueue = queue ?: dispatch_get_main_queue();
        
        // set short timer
        if (interval > 0) {
            innerTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, targetQueue);
            dispatch_source_set_timer(innerTimer, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
            __weak __typeof(self) weakSelf = self;
            dispatch_source_set_event_handler(innerTimer, ^{
                [weakSelf timerFiredMethod];
                if (!weakSelf.repeat) {
                    [weakSelf cancel];
                }
            });
            dispatch_resume(innerTimer);
        } else {
            innerTimer = nil;
        }
    }
    return self;
}

- (void)delay {
    [self cancel];
    
    innerTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, targetQueue);
    dispatch_source_set_timer(innerTimer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), (interval * NSEC_PER_SEC), 0);
    __weak __typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(innerTimer, ^{
        [weakSelf timerFiredMethod];
        if (!weakSelf.repeat) {
            [weakSelf cancel];
        }
    });
    dispatch_resume(innerTimer);
}

- (void)cancel {
    if (innerTimer) {
        dispatch_source_cancel(innerTimer);
        innerTimer = nil;
    }
}

- (void)clearDelegateAndCancel {
    delegate = nil;
    [self cancel];
}

- (void)timerFiredMethod {
    if ([self.delegate respondsToSelector:@selector(didReceiveTimerMark:)]) {
        [self.delegate didReceiveTimerMark:self];
    }
}

- (void) dealloc {
    [self clearDelegateAndCancel];
}


@end
