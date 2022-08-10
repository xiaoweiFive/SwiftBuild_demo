//
//  MDCountLimitTimer.h
//  MomoChat
//
//  Created by Hanx on 12-9-28.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

DEPRECATED_MSG_ATTRIBUTE("没看明白这个类有什么用，推荐使用 MDSourceTimer")
@interface MDCountLimitTimer : NSObject

+ (instancetype)timerWithInterval:(float)interval delegate:(id)delegate repeat:(BOOL)repeat limit:(NSInteger)limit;
- (instancetype)initTimerWithInterval:(float)interval delegate:(id)delegate repeat:(BOOL)repeat limit:(NSInteger)limit;
- (void)delay;

@end
