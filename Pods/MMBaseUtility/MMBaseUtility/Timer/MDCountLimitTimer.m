//
//  MDCountLimitTimer.m
//  MomoChat
//
//  Created by Hanx on 12-9-28.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "MDCountLimitTimer.h"
#import "MFTimer.h"

@interface MDCountLimitTimer ()

@property (nonatomic, strong) MFTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger limit;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
@implementation MDCountLimitTimer
#pragma clang diagnostic pop

+ (instancetype)timerWithInterval:(float)interval delegate:(id)delegate repeat:(BOOL)repeat limit:(NSInteger)limit
{
    return [[MDCountLimitTimer alloc] initTimerWithInterval:interval delegate:delegate repeat:repeat limit:limit];
}

- (instancetype)initTimerWithInterval:(float)interval delegate:(id)delegate repeat:(BOOL)repeat limit:(NSInteger)limit
{
    self = [super init];
    if (self) {
        _count = 0;
        _limit = limit;
        _timer = [MFTimer timerWithInterval:interval delegate:delegate repeat:repeat];
    }
    return self;
}

- (void)dealloc
{
    [_timer clearDelegateAndCancel];
}

- (void)delay
{
    if (self.count < self.limit) {
        self.count++;
        if (self.timer) {
            [self.timer delay];
        }
    }
}

@end
