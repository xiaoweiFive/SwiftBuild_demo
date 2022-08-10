//
//  NSTimer+MDBlockSupport.m
//  MomoChat
//
//  Created by Allen on 20/8/14.
//  Copyright (c) 2014 wemomo.com. All rights reserved.
//

#import "NSTimer+MDBlockSupport.h"

@implementation NSTimer (MDBlockSupport)

+ (NSTimer *)md_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(md_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)md_commonTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats {
    NSTimer *timer = [self timerWithTimeInterval:interval target:self selector:@selector(md_blockInvoke:) userInfo:[block copy] repeats:repeats];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (void)md_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

+ (NSTimer *)md_scheduledTimerWithTimeInterval:(NSTimeInterval)interval scheduledTarget:(id)target scheduldSelector:(SEL)selector repeats:(BOOL)repeats {
    if (target && selector) {
        NSDictionary *infoDic = @{@"target" : [NSValue valueWithPointer:(__bridge const void *)(target)], @"sel" : NSStringFromSelector(selector)};
        return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(md_selectorInvoke:) userInfo:infoDic repeats:repeats];
    } else {
        return nil;
    }
}

+ (NSTimer *)md_commonTimerWithTimeInterval:(NSTimeInterval)interval scheduledTarget:(id)target scheduldSelector:(SEL)selector repeats:(BOOL)repeats {
    if (target && selector) {
        NSDictionary *infoDic = @{@"target" : [NSValue valueWithPointer:(__bridge const void *)(target)], @"sel" : NSStringFromSelector(selector)};
        NSTimer *timer = [self timerWithTimeInterval:interval target:self selector:@selector(md_selectorInvoke:) userInfo:infoDic repeats:repeats];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        return timer;
    } else {
        return nil;
    }
}


+ (void)md_selectorInvoke:(NSTimer *)timer {
    NSDictionary *infoDic = (NSDictionary *)timer.userInfo;
    
    id target = [[infoDic objectForKey:@"target"] pointerValue];
    NSString *selectorString = [infoDic objectForKey:@"sel"];
    
    if (selectorString && target) {
        SEL selector = NSSelectorFromString(selectorString);
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector withObject:timer];
#pragma clang diagnostic pop
        }
    }
}

@end
