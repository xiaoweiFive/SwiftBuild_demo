//
//  FrameManager.h
//  MomoChat
//
//  Created by 晗晖 刘 on 12-10-8.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include("MDScreenInstance.h")
#import "MDScreenInstance.h"
#endif

#ifndef FrameManager_h
#define FrameManager_h

NS_INLINE  BOOL isFloatEqual(float value1, float value2)
{
    return fabsf(value1 - value2) <= __FLT_EPSILON__;
}

//实时宽高, 跟随屏幕旋转发生改变
#define MDScreenRealTimeWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define MDScreenRealTimeHeight CGRectGetHeight([[[UIApplication sharedApplication].delegate window] bounds])

//竖屏宽高
#define MDScreenWidth ([MDScreenInstance shared].screenWidth)
#define MDScreenHeight ([MDScreenInstance shared].screenHeight)

//视频使用
#define MLScreenWidth MDScreenRealTimeWidth
#define MLScreenHeight MDScreenRealTimeHeight

#define I_SCREEN_WIDTH 320.f
#define I4_SCREEN_HEIGHT 480.f
#define I5_SCREEN_HEIGHT 568.f
#define I6_SCREEN_HEIGHT 667.f
#define IX_SCREEN_HEIGHT 812.f
#define IX_R_MAX_SCREEN_HEIGHT 896.f
#define I12_PRO_SCREEN_HEIGHT 844.f
#define I12_MAX_SCREEN_HEIGHT 926.f

#define IS_IPHONE_X [FrameManager isIPhoneX]

#define STATUS_BAR_HEIGHT [FrameManager statusBarHeight]
#define NAV_BAR_HEIGHT 44.f
#define MDStatusBarAndNavigationBarHeight (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define HOME_INDICATOR_HEIGHT [FrameManager homeIndicatorHeight]

//这个取值和statusBar高度一样了
#define SENSOR_HOUSING_HEIGHT [FrameManager sensorHousingHeight]

//刘海的固定高度
#define SENSOR_RESERVED_HEIGHT [FrameManager sensorReservedHeight]

#define TAB_BAR_HEIGHT (HOME_INDICATOR_HEIGHT + 50.f)

#define SCREEN_TOP_INSET (SAFEAREA_TOP_MARGIN + NAV_BAR_HEIGHT) // 除iPhone12 mini与MDStatusBarAndNavigationBarHeight相等
#define SCREEN_SAFE_HEIGHT (MDScreenHeight - HOME_INDICATOR_HEIGHT)

#define SAFEAREA_FRINGE_HEIGHT SENSOR_HOUSING_HEIGHT ///< 刘海真实的高度
#define SAFEAREA_TOP_MARGIN [FrameManager safeAreaTopMargin] ///< 安全区域上方高度（不含NavigationBar）
#define SAFEAREA_BOTTOM_MARGIN HOME_INDICATOR_HEIGHT ///< 安全区域下方高度

#define ONE_PX [FrameManager onePX]

#define MDAdapterScale (MDScreenWidth / 375.f) // 以6、X的尺寸为基础
#ifndef MDScaleValue
#define MDScaleValue(value) ((value) * MDAdapterScale)
#endif

#ifndef MDRectAdaptMake
#define MDRectAdaptMake(x, y, width, height) \
CGRectMake((x) * MDAdapterScale, (y) * MDAdapterScale, (width) * MDAdapterScale, (height) * MDAdapterScale)
#endif

#endif /* FrameManager_h */

@interface FrameManager : NSObject

// 根据[[UIDevice currentDevice] isIPhoneX]判断刘海屏手机。（为兼容modular_headers，封装到内部）
+ (BOOL)isIPhoneX;

// 获取屏幕宽度
+ (CGFloat)screenWidth;
// 获取屏幕高度
+ (CGFloat)screenHeight;

// StatusBar高度
+ (CGFloat)statusBarHeight;

// 传感器外壳（刘海）高度，非刘海屏或iPad返回0，不建议使用了
+ (CGFloat)sensorHousingHeight __attribute__((deprecated("此方法不推荐使用用,返回的是statusBar的高度，如果需要刘海的固定高度请使用sensorReservedHeight方法")));

//返回刘海的高度，业务方使用的时候需要自己判断当前屏幕的方向
+ (CGFloat)sensorReservedHeight;

// 刘海屏时底部保留高度，非刘海屏或iPad返回0
+ (CGFloat)homeIndicatorHeight;

// 竖屏时安全区域上方高度
+ (CGFloat)safeAreaTopMargin;

+ (CGFloat)onePX;

@end
