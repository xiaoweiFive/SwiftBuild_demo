//
//  MDScreenInstance.m
//  MomoChat
//
//  Created by litianpeng on 2020/4/8.
//  Copyright © 2020 wemomo.com. All rights reserved.
//

#import "MDScreenInstance.h"

@interface MDScreenInstance ()

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation MDScreenInstance

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static MDScreenInstance *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 从横屏进入后台, 长时间就会被后台杀死, 再起启动的时候, 偶然还是横屏状态
        UIInterfaceOrientation deviceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        if (deviceOrientation == UIInterfaceOrientationLandscapeLeft || deviceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.screenWidth = CGRectGetHeight([UIApplication sharedApplication].delegate.window.bounds);
            self.screenHeight = CGRectGetWidth([UIScreen mainScreen].bounds);
        } else {
            self.screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
            self.screenHeight = CGRectGetHeight([UIApplication sharedApplication].delegate.window.bounds);
        }
    }
    return self;
}

- (void)updateFrame {
    if (CGRectGetHeight([UIApplication sharedApplication].delegate.window.bounds) > CGRectGetWidth([UIScreen mainScreen].bounds)) {
        self.screenHeight = CGRectGetHeight([UIApplication sharedApplication].delegate.window.bounds);
    }
}

@end
