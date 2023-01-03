/*
 https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.h
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 5.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIDevicePlatform) {
    UIDeviceUnknown,
    
    UIDeviceiPhoneSimulator,
    UIDeviceiPhoneSimulatoriPhone, // both regular and iPhone 4 devices
    UIDeviceiPhoneSimulatoriPad,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice5CiPhone,
    UIDevice5SiPhone,
    UIDevice6iPhone,
    UIDevice6PlusiPhone,
    UIDevice6SiPhone,
    UIDevice6SPlusiPhone,
    UIDeviceSEiPhone,
    UIDevice7iPhone,
    UIDevice7PlusiPhone,
    UIDevice8iPhone,
    UIDevice8PlusiPhone,
    UIDeviceXiPhone,
    UIDeviceXSiPhone,
    UIDeviceXSMaxiPhone,
    UIDeviceXRiPhone,
    UIDevice11iPhone,
    UIDevice11ProiPhone,
    UIDevice11ProMaxiPhone,
    UIDeviceSE2GiPhone,
    UIDevice12miniiPhone,
    UIDevice12iPhone,
    UIDevice12ProiPhone,
    UIDevice12ProMaxiPhone,

    UIDevice13miniiPhone,
    UIDevice13iPhone,
    UIDevice13ProiPhone,
    UIDevice13ProMaxiPhone,
    
    UIDeviceSE3rdGen,
    UIDevice14iPhone,
    UIDevice14PlusiPhone,
    UIDevice14ProIPhone,
    UIDevice14ProMaxiPhone,

    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    UIDevice5GiPod,
    UIDevice6GiPod,
    UIDevice7GiPod,
    
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    UIDeviceAiriPad,
    UIDeviceAir2iPad,
    UIDevicePro9p7InchiPad,
    UIDevicePro12p9InchiPad,
    UIDevice5GiPad,
    UIDevicePro10p5InchiPad,
    UIDevicePro12p9Inch2GiPad,
    UIDevice6GiPad,
    UIDevicePro11InchiPad,
    UIDevicePro12p9Inch3GiPad,
    UIDeviceAir3GiPad,
    UIDevice7GiPad,
    UIDevicePro11Inch2GiPad,
    UIDevicePro11Inch3rdPad,
    UIDevicePro12p9Inch4GiPad,
    UIDevicePro12p9Inch5thPad,
    UIDevice10p2Inch9thPad,
    UIDevice8GiPad,
    UIDeviceAir4GiPad,
    UIDeviceAir5thGenWiFi,
    UIDeviceAir5thGenWIFICellular,
    
    UIDeviceiPadmini,
    UIDeviceiPadminiRetina,
    UIDeviceiPadmini3,
    UIDeviceiPadmini4,
    UIDeviceiPadmini5G,
    UIDeviceiPadmini6th,
    
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    UIDeviceAppleTV4K,
    UIDeviceUnknownAppleTV,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceIFPGA
};

@interface UIDevice (Hardware)

- (NSString *)platform;
- (NSString *)hwmodel;
- (UIDevicePlatform)platformType;
- (NSString *)platformString;

- (NSUInteger)cpuFrequency;
- (NSUInteger)busFrequency;
- (NSUInteger)totalMemory;
- (NSUInteger)userMemory;

- (NSNumber *)totalDiskSpace;
- (NSNumber *)freeDiskSpace;

- (NSString *)macaddress;
- (NSString *)osLanguageAndCountry;

/**
 根据UIDevicePlatform枚举值判断，是否大于等于指定机型（仅支持iPhone，ipad、iwatch等直接返回NO）
 @param devicePlatform 指定机型
 @return 大于等于返回YES，小于返回NO
 */
- (BOOL)isIphoneGreaterOrEqualDevicePlatform:(UIDevicePlatform)devicePlatform;

/**
 根据UIDevicePlatform枚举值判断，是否小于等于指定机型（仅支持iPhone，ipad、iwatch等直接返回NO）
 @param devicePlatform 指定机型
 @return 小于等于返回YES，大于返回NO
 */
- (BOOL)isIphoneLessOrEqualDevicePlatform:(UIDevicePlatform)devicePlatform;

/// 是否是刘海屏
- (BOOL)isIPhoneX;

@end
