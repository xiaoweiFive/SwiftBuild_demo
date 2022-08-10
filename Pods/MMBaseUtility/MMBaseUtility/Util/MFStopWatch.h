//
//  MFStopWatch.h
//  MomoChat
//
//  Created by Latermoon on 12-10-31.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 提供一个简单的运行时间计时
 */
@interface MFStopWatch : NSObject

+ (MFStopWatch *)stopWatch;
- (instancetype)init;

- (MFStopWatch *)start;
- (MFStopWatch *)stop;
- (void)reset;
- (NSTimeInterval)interval;

@end
