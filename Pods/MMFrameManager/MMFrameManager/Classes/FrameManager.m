//
//  FrameManager.m
//  MomoChat
//
//  Created by 晗晖 刘 on 12-10-8.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "FrameManager.h"

@implementation FrameManager

+ (BOOL)isIPhoneX
{
    static BOOL is = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
        if (height <= 20) {
            UIWindow *win = [UIApplication sharedApplication].keyWindow;
            is = win.safeAreaInsets.bottom > 0;
        } else {
            is = YES;
        }
    });
    
    return is;
}

+ (CGFloat)screenWidth
{
    return MDScreenWidth;
}

+ (CGFloat)screenHeight
{
    return MDScreenHeight;
}

static CGFloat statusbarHeight = 0;
+ (CGFloat)statusBarHeight
{
    if (statusbarHeight > 0) {
        return statusbarHeight;
    }
    
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (height > 0) {
        statusbarHeight = height;
    } else {
        if ([self isIPhoneX]) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            height = window.safeAreaInsets.top;
        } else {
            height = 20;
        }
    }
    return height;
}

+ (CGFloat)sensorHousingHeight
{
    return [self statusBarHeight];
}

+ (CGFloat)sensorReservedHeight
{
    static CGFloat height = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self isIPhoneX]) {
            if (@available(iOS 11.0, *)) {
                UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                UIInterfaceOrientation currentOrientation = UIInterfaceOrientationPortrait;
                
                if (@available(iOS 13.0, *)) {
                    currentOrientation = window.windowScene.interfaceOrientation;
                } else {
                    currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
                }
                
                switch (currentOrientation) {
                    case UIInterfaceOrientationPortrait:{
                        height = window.safeAreaInsets.top;
                    }
                        break;
                    case UIInterfaceOrientationPortraitUpsideDown:{
                        height = window.safeAreaInsets.bottom;
                    }
                        break;
                    case UIInterfaceOrientationLandscapeLeft:{
                        height = window.safeAreaInsets.left;
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:{
                        height = window.safeAreaInsets.right;
                    }
                        break;
                    default:{
                        height = window.safeAreaInsets.top;
                    }
                        break;
                }

            }
        }
    });
    
    return height;
}

+ (CGFloat)homeIndicatorHeight
{
    CGFloat height = 0.f;
    if ([self isIPhoneX]) {
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            height = window.safeAreaInsets.bottom;
        }
    }
    
    return height;
}

+ (CGFloat)safeAreaTopMargin
{
    return [self statusBarHeight];
}

+ (CGFloat)onePX
{
    static CGFloat onePx;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        onePx = 1.f / [UIScreen mainScreen].scale;
    });
    return onePx;
}

@end
