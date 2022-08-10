//
//  MDDisplayLinkProxy.m
//  MomoChat
//
//  Created by Allen on 2018/9/1.
//  Copyright © 2018年 wemomo.com. All rights reserved.
//

#import "MDDisplayLinkProxy.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface MDDisplayLinkProxy ()

@property (nonatomic, weak) id weakTarget;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation MDDisplayLinkProxy

- (instancetype)initWithTarget:(id)target triggeredSelector:(SEL)selector frameInterval:(NSInteger)interval
{
    self = [super init];
    if (self) {
        _weakTarget = target;
        _selector = selector;
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(dispalyLinkTrigger:)];
        _displayLink.preferredFramesPerSecond = ceil(60.0/interval);
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)dispalyLinkTrigger:(id)sender
{
    ((void (*) (id, SEL, id))objc_msgSend)(_weakTarget, _selector, sender);
}

- (void)invalidate
{
    [_displayLink invalidate];
    _displayLink = nil;
}

- (BOOL)isPaused
{
    return [_displayLink isPaused];
}

- (void)setPaused:(BOOL)paused
{
    _displayLink.paused = paused;
}

@end
