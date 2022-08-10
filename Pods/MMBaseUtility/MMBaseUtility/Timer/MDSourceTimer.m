//
//  MDSourceTimer.m
//  MomoChat
//
//  Created by Allen on 3/25/16.
//  Copyright © 2016 wemomo.com. All rights reserved.
//

#import "MDSourceTimer.h"

#if !__has_feature(objc_arc)
#error MDSourceTimer must be built with ARC.
#endif

@interface MDSourceTimer ()

@property (nonatomic, strong) dispatch_source_t         innerSource;

@property (nonatomic, weak) id                          actionTarget;

@property (nonatomic, assign) SEL                       actionSelector;

@property (nonatomic, strong) dispatch_queue_t          targetQueue;

@property (nonatomic, strong) dispatch_semaphore_t      lock;

@property (nullable, readwrite, strong) id              userInfo;

@property (nonatomic, assign) BOOL                      repeats;

@property (readwrite, getter=isValid) BOOL              valid;

@property (readwrite, assign) NSTimeInterval            timeInterval;

@property (nonatomic, copy, nullable) void(^scheduleBlock)(MDSourceTimer *timer);

@end


@implementation MDSourceTimer

+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    return [[self class] scheduledTimerWithTimeInterval:interval targetQueue:nil target:aTarget selector:aSelector userInfo:userInfo repeat:yesOrNo];
}


+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval targetQueue:(nullable dispatch_queue_t)targetQueue target:(id)target selector:(SEL)selector userInfo:(nullable id)userInfo repeat:(BOOL)yesOrNo
{
    MDSourceTimer *timer = [[self alloc] initWithTimeInterval:interval targetQueue:targetQueue target:target selector:selector userInfo:userInfo repeat:yesOrNo];
    [timer fire];
    return timer;
}

+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti targetQueue:(nullable dispatch_queue_t)targetQueue repeat:(BOOL)yesOrNo block:(void (^)(MDSourceTimer *timer))block
{
    return [self scheduledTimerWithTimeInterval:ti targetQueue:targetQueue timerMode:MDSourceTimerModeRunWhileApplicationActive nanoSecondsOfLeeway:0 repeat:yesOrNo block:block];
}

+ (MDSourceTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti targetQueue:(nullable dispatch_queue_t)targetQueue timerMode:(MDSourceTimerMode)mode nanoSecondsOfLeeway:(NSInteger)leeway repeat:(BOOL)yesOrNo  block:(void (^)(MDSourceTimer *timer))block
{
    MDSourceTimer *timer = [[MDSourceTimer alloc] initWithTimeInterval:ti targetQueue:targetQueue target:nil selector:nil userInfo:nil repeat:yesOrNo];
    timer.timerMode = mode;
    timer.scheduleBlock = block;
    timer.nanoSecondsOfLeeway = leeway;
    [timer fire];
    
    return timer;
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval targetQueue:(nullable dispatch_queue_t)targetQueue target:(nullable id)target selector:(nullable SEL)selector userInfo:(nullable id)userInfo repeat:(BOOL)yesOrNo
{
    self = [super init];
    if (self) {
        _actionTarget = target;
        _actionSelector = selector;
        _userInfo = userInfo;
        _repeats = yesOrNo;
        _timerMode = MDSourceTimerModeRunWhileApplicationActive;
        _timeInterval = interval;
        
        if (interval > 0.0) {
            _valid = YES;
            _lock = dispatch_semaphore_create(0);
            dispatch_semaphore_signal(_lock);
            _targetQueue = targetQueue ?: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        }
    }
    
    return self;
}

- (void)dealloc
{
    // 没必要在dealloc中将成员变量指向nil，cancel即可
//    [self invalidate];
    if (_valid && _innerSource) {
        dispatch_source_cancel(_innerSource);
    }
}

- (void)fire
{
    if (!_innerSource && _valid) {
        _innerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _targetQueue);

        dispatch_time_t time;
        
        if (_timerMode == MDSourceTimerModeAlwaysRun) {
            time = dispatch_walltime(NULL, _timeInterval * NSEC_PER_SEC);
        } else {
            time = dispatch_time(DISPATCH_TIME_NOW, _timeInterval * NSEC_PER_SEC);
        }

        if (_repeats) {
            dispatch_source_set_timer(_innerSource, time, (_timeInterval * NSEC_PER_SEC), _nanoSecondsOfLeeway);
        } else {
            dispatch_source_set_timer(_innerSource, time, DISPATCH_TIME_FOREVER, _nanoSecondsOfLeeway);
        }
        
        __weak __typeof(self) weakSelf = self;
        if (self.scheduleBlock) {
            dispatch_source_set_event_handler(_innerSource, ^{
                __strong __typeof(self) strongSelf = weakSelf;
                if (strongSelf.valid && strongSelf.scheduleBlock) {
                    strongSelf.scheduleBlock(strongSelf);
                }
            });
        } else {
            dispatch_source_set_event_handler(_innerSource, ^{
                __strong __typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf timerFiredMethod];
                }
            });
        }
        
        dispatch_resume(_innerSource);
    }
}

- (void)delay {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    dispatch_source_cancel(_innerSource);
    _innerSource = nil;
    [self fire];
    dispatch_semaphore_signal(_lock);
}


- (void)invalidate
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);

    if (_valid) {
        _valid = NO;
        _actionTarget =  nil;
        _actionSelector = NULL;
        self.scheduleBlock = nil;
        dispatch_source_cancel(_innerSource);
        _innerSource = nil;
    }
    
    dispatch_semaphore_signal(_lock);
}

- (void)timerFiredMethod
{
    if (!_valid) {
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL tempSel = self.actionSelector;
    if (tempSel && self.actionTarget) {
        if ([self.actionTarget respondsToSelector:tempSel]) {
            [self.actionTarget performSelector:tempSel withObject:self];
        }
    }
#pragma clang diagnostic pop
    
    if (!_repeats) {
        [self invalidate];
    }
}

@end
