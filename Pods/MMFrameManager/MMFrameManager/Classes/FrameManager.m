//
//  FrameManager.m
//  MomoChat
//
//  Created by 晗晖 刘 on 12-10-8.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "FrameManager.h"
#import <MMBaseUtility/MMBaseUtility.h>

@implementation FrameManager

+ (BOOL)isIPhoneX
{
    return [[UIDevice currentDevice] isIPhoneX];
}

+ (CGFloat)screenWidth
{
    return MDScreenWidth;
}

+ (CGFloat)screenHeight
{
    return MDScreenHeight;
}

+ (CGFloat)statusBarHeight
{
    CGFloat height = 20.f;
    if ([self isIPhoneX]) {
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            height = window.safeAreaInsets.top;
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
