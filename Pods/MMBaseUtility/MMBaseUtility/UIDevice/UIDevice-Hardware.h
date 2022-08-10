/*
 https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.h
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 5.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

#define IFPGA_NAMESTRING                @"iFPGA"

#define IPHONE_1G_NAMESTRING            @"iPhone 1G"
#define IPHONE_3G_NAMESTRING            @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING           @"iPhone 3GS"
#define IPHONE_4_NAMESTRING             @"iPhone 4"
#define IPHONE_4S_NAMESTRING            @"iPhone 4S"
#define IPHONE_5_NAMESTRING             @"iPhone 5"
#define IPHONE_5C_NAMESTRING            @"iPhone 5C"
#define IPHONE_5S_NAMESTRING            @"iPhone 5S"
#define IPHONE_6_NAMESTRING             @"iPhone 6"
#define IPHONE_6PLUS_NAMESTRING         @"iPhone 6 Plus"
#define IPHONE_6S_NAMESTRING            @"iPhone 6S"
#define IPHONE_6SPLUS_NAMESTRING        @"iPhone 6S Plus"
#define IPHONE_SE_NAMESTRING            @"iPhone SE"
#define IPHONE_7_NAMESTRING             @"iPhone 7"
#define IPHONE_7PLUS_NAMESTRING         @"iPhone 7 Plus"
#define IPHONE_8_NAMESTRING             @"iPhone 8"
#define IPHONE_8PLUS_NAMESTRING         @"iPhone 8 Plus"
#define IPHONE_X_NAMESTRING             @"iPhone X"
#define IPHONE_XS_NAMESTRING            @"iPhone XS"
#define IPHONE_XSMAX_NAMESTRING         @"iPhone XS Max"
#define IPHONE_XR_NAMESTRING            @"iPhone XR"
#define IPHONE_11_NAMESTRING            @"iPhone 11"
#define IPHONE_11PRO_NAMESTRING         @"iPhone 11 Pro"
#define IPHONE_11PROMAX_NAMESTRING      @"iPhone 11 Pro Max"
#define IPHONE_SE2G_NAMESTRING          @"iPhone SE 2G"
#define IPHONE_12MINI_NAMESTRING        @"iPhone 12 mini"
#define IPHONE_12_NAMESTRING            @"iPhone 12"
#define IPHONE_12PRO_NAMESTRING         @"iPhone 12 Pro"
#define IPHONE_12PROMAX_NAMESTRING      @"iPhone 12 Pro Max"

#define IPHONE_13MINI_NAMESTRING        @"iPhone 13 mini"
#define IPHONE_13_NAMESTRING            @"iPhone 13"
#define IPHONE_13PRO_NAMESTRING         @"iPhone 13 Pro"
#define IPHONE_13PROMAX_NAMESTRING      @"iPhone 13 Pro Max"


#define IPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define IPOD_1G_NAMESTRING              @"iPod touch 1G"
#define IPOD_2G_NAMESTRING              @"iPod touch 2G"
#define IPOD_3G_NAMESTRING              @"iPod touch 3G"
#define IPOD_4G_NAMESTRING              @"iPod touch 4G"
#define IPOD_5G_NAMESTRING              @"iPod touch 5G"
#define IPOD_6G_NAMESTRING              @"iPod touch 6G"
#define IPOD_7G_NAMESTRING              @"iPod touch 7G"
#define IPOD_UNKNOWN_NAMESTRING         @"Unknown iPod"

#define IPAD_1G_NAMESTRING              @"iPad 1G"
#define IPAD_2G_NAMESTRING              @"iPad 2G"
#define IPAD_3G_NAMESTRING              @"iPad 3G"
#define IPAD_4G_NAMESTRING              @"iPad 4G"
#define IPAD_AIR_NAMESTRING             @"iPad Air"
#define IPAD_AIR2_NAMESTRING            @"iPad Air 2"
#define IPAD_PRO9P7INCH_NAMESTRING      @"iPad Pro 9.7-inch"
#define IPAD_PRO12P9INCH_NAMESTRING     @"iPad Pro 12.9-inch"
#define IPAD_5G_NAMESTRING              @"iPad 5G"
#define IPAD_PRO10P5INCH_NAMESTRING     @"iPad Pro 10.5-inch"
#define IPAD_PRO12P9INCH2G_NAMESTRING   @"iPad Pro 12.9-inch 2G"
#define IPAD_6G_NAMESTRING              @"iPad 6G"
#define IPAD_PRO11INCH_NAMESTRING       @"iPad Pro 11-inch"
#define IPAD_PRO12P9INCH3G_NAMESTRING   @"iPad Pro 12.9-inch 3G"
#define IPAD_AIR3G_NAMESTRING           @"iPad Air 3G"
#define IPAD_7G_NAMESTRING              @"iPad 7G"
#define IPAD_PRO11INCH2G_NAMESTRING     @"iPad Pro 11-inch 2G"
#define IPAD_PRO12P9INCH4G_NAMESTRING   @"iPad Pro 12.9-inch 4G"
#define IPAD_8G_NAMESTRING              @"iPad 8G"
#define IPAD_AIR4G_NAMESTRING           @"iPad Air 4G"

#define IPAD_MINI_NAMESTRING            @"iPad mini"
#define IPAD_MINI_RETINA_NAMESTRING     @"iPad mini Retina"
#define IPAD_MINI3_NAMESTRING           @"iPad mini 3"
#define IPAD_MINI4_NAMESTRING           @"iPad mini 4"
#define IPAD_MINI5G_NAMESTRING          @"iPad mini 5G"
#define IPAD_UNKNOWN_NAMESTRING         @"Unknown iPad"

#define IPAD_PRO12P9INCH5TH_NAMESTRING    @"iPad Pro 12.9-inch 5th"
#define IPAD_PRO11INCH3RD_NAMESTRING      @"iPad Pro 11-inch 3rd"
#define IPAD_10P2INCH9TH_NAMESTRING       @"iPad Pro 10.2-inch 9th"
#define IPAD_MINI6_NAMESTRING             @"iPad mini 6"

#define APPLETV_2G_NAMESTRING           @"Apple TV 2G"
#define APPLETV_3G_NAMESTRING           @"Apple TV 3G"
#define APPLETV_4G_NAMESTRING           @"Apple TV 4G"
#define APPLETV_4K_NAMESTRING           @"Apple TV 4K"
#define APPLETV_UNKNOWN_NAMESTRING      @"Unknown Apple TV"

#define IOS_FAMILY_UNKNOWN_DEVICE       @"Unknown iOS device"

#define IPHONE_SIMULATOR_NAMESTRING         @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING  @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING    @"iPad Simulator"

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
