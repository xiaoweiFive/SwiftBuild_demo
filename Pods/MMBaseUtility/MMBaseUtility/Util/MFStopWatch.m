//
//  MFStopWatch.m
//  MomoChat
//
//  Created by Latermoon on 12-10-31.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "MFStopWatch.h"

@interface MFStopWatch ()
@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, assign) BOOL isRuning;
@end

@implementation MFStopWatch

+ (MFStopWatch *)stopWatch
{
    return [[MFStopWatch alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isRuning = NO;
    }
    return self;
}

- (MFStopWatch *)start
{
    self.isRuning = YES;
    self.beginDate = [NSDate date];
    return self;
}

- (MFStopWatch *)stop
{
    self.isRuning = NO;
    self.endDate = [NSDate date];
    return self;
}

- (void)reset
{
    self.beginDate = [NSDate date];
}

- (NSTimeInterval)interval
{
    if (self.isRuning) {
        return [[NSDate date] timeIntervalSinceDate:self.beginDate];
    } else {
        return [self.endDate timeIntervalSinceDate:self.beginDate];
    }
}

@end
