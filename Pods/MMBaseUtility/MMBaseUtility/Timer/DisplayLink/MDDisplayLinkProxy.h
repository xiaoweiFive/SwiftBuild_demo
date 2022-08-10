//
//  MDDisplayLinkProxy.h
//  MomoChat
//
//  Created by Allen on 2018/9/1.
//  Copyright © 2018年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//主要用来解决displayLink会强引用target，导致循环引用，而使用MDWeakProxy的解决方式会有不够高效的问题
@interface MDDisplayLinkProxy : NSObject

@property (nonatomic, assign, getter=isPaused) BOOL paused;

- (instancetype)initWithTarget:(id)target triggeredSelector:(SEL)selector frameInterval:(NSInteger)interval;

//必须得调用这个方法
- (void)invalidate;

@end
