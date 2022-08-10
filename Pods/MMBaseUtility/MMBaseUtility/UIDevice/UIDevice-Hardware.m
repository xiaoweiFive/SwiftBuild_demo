/*
 https://github.com/erica/uidevice-extension/blob/master/UIDevice-Hardware.m
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 5.0 Edition
 BSD License, Use at your own risk
 */

// Thanks to Emanuele Vulcano, Kevin Ballard/Eridius, Ryandjohnson, Matt Brown, etc.

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UIDevice-Hardware.h"

@implementation UIDevice (Hardware)
/*
 i386, x86_64 -> iPhone Simulator
 */

/*修改参考网站   (by zhang.zheng, wang.xu_1106)
 http://www.everyi.com/by-identifier/ipod-iphone-ipad-specs-by-model-identifier.html
 https://www.theiphonewiki.com/wiki/Models
 https://gist.github.com/adamawolf/3048717
 */

#pragma mark sysctlbyname utils
- (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

- (NSString *)hwmodel
{
    return [self getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
- (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger)cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger)busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger)totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger)userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger)maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!
- (NSNumber *)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark - platform type and name utils
- (NSDictionary *)platFormIphoneInforDic {
    NSDictionary *iphoneInforDic = @{@"iPhone1,1":@(UIDevice1GiPhone),
                                     @"iPhone1,2":@(UIDevice3GiPhone),
                                     @"iPhone2,1":@(UIDevice3GSiPhone),
                                     @"iPhone3,1":@(UIDevice4iPhone),
                                     @"iPhone3,2":@(UIDevice4iPhone),
                                     @"iPhone3,3":@(UIDevice4iPhone),
                                     @"iPhone4,1":@(UIDevice4SiPhone),
                                     @"iPhone5,1":@(UIDevice5iPhone),
                                     @"iPhone5,2":@(UIDevice5iPhone),
                                     @"iPhone5,3":@(UIDevice5CiPhone),
                                     @"iPhone5,4":@(UIDevice5CiPhone),
                                     @"iPhone6,1":@(UIDevice5SiPhone),
                                     @"iPhone6,2":@(UIDevice5SiPhone),
                                     @"iPhone7,1":@(UIDevice6PlusiPhone),
                                     @"iPhone7,2":@(UIDevice6iPhone),
                                     @"iPhone8,1":@(UIDevice6SiPhone),
                                     @"iPhone8,2":@(UIDevice6SPlusiPhone),
                                     @"iPhone8,4":@(UIDeviceSEiPhone),
                                     @"iPhone9,1":@(UIDevice7iPhone),
                                     @"iPhone9,3":@(UIDevice7iPhone),
                                     @"iPhone9,2":@(UIDevice7PlusiPhone),
                                     @"iPhone9,4":@(UIDevice7PlusiPhone),
                                     @"iPhone10,1":@(UIDevice8iPhone),
                                     @"iPhone10,4":@(UIDevice8iPhone),
                                     @"iPhone10,2":@(UIDevice8PlusiPhone),
                                     @"iPhone10,5":@(UIDevice8PlusiPhone),
                                     @"iPhone10,3":@(UIDeviceXiPhone),
                                     @"iPhone10,6":@(UIDeviceXiPhone),
                                     @"iPhone11,2":@(UIDeviceXSiPhone),
                                     @"iPhone11,4":@(UIDeviceXSMaxiPhone),
                                     @"iPhone11,6":@(UIDeviceXSMaxiPhone),
                                     @"iPhone11,8":@(UIDeviceXRiPhone),
                                     @"iPhone12,1":@(UIDevice11iPhone),
                                     @"iPhone12,3":@(UIDevice11ProiPhone),
                                     @"iPhone12,5":@(UIDevice11ProMaxiPhone),
                                     @"iPhone12,8":@(UIDeviceSE2GiPhone),
                                     @"iPhone13,1":@(UIDevice12miniiPhone),
                                     @"iPhone13,2":@(UIDevice12iPhone),
                                     @"iPhone13,3":@(UIDevice12ProiPhone),
                                     @"iPhone13,4":@(UIDevice12ProMaxiPhone),
                                     @"iPhone14,2":@(UIDevice13ProiPhone),
                                     @"iPhone14,3":@(UIDevice13ProMaxiPhone),
                                     @"iPhone14,4":@(UIDevice13miniiPhone),
                                     @"iPhone14,5":@(UIDevice13iPhone),
                  };
    return iphoneInforDic;
}

- (NSDictionary *)platFormiPodInforDic {
    NSDictionary *ipodInforDic = @{@"iPod1,1":@(UIDevice1GiPod),
                                   @"iPod2,1":@(UIDevice2GiPod),
                                   @"iPod3,1":@(UIDevice3GiPod),
                                   @"iPod4,1":@(UIDevice4GiPod),
                                   @"iPod5,1":@(UIDevice5GiPod),
                                   @"iPod7,1":@(UIDevice6GiPod),
                                   @"iPod9,1":@(UIDevice7GiPod),
                  };
    return ipodInforDic;
}

- (NSDictionary *)platFormiPadInforDic {
    NSDictionary *ipadInforDic = @{@"iPad1,1":@(UIDevice1GiPad),
                                   @"iPad1,2":@(UIDevice1GiPad),
                                   @"iPad2,1":@(UIDevice2GiPad),
                                   @"iPad2,2":@(UIDevice2GiPad),
                                   @"iPad2,3":@(UIDevice2GiPad),
                                   @"iPad2,4":@(UIDevice2GiPad),
                                   @"iPad3,1":@(UIDevice3GiPad),
                                   @"iPad3,2":@(UIDevice3GiPad),
                                   @"iPad3,3":@(UIDevice3GiPad),
                                   @"iPad3,4":@(UIDevice4GiPad),
                                   @"iPad3,5":@(UIDevice4GiPad),
                                   @"iPad3,6":@(UIDevice4GiPad),
                                   @"iPad4,1":@(UIDeviceAiriPad),
                                   @"iPad4,2":@(UIDeviceAiriPad),
                                   @"iPad4,3":@(UIDeviceAiriPad),
                                   @"iPad5,3":@(UIDeviceAir2iPad),
                                   @"iPad5,4":@(UIDeviceAir2iPad),
                                   @"iPad6,3":@(UIDevicePro9p7InchiPad),
                                   @"iPad6,4":@(UIDevicePro9p7InchiPad),
                                   @"iPad6,7":@(UIDevicePro12p9InchiPad),
                                   @"iPad6,8":@(UIDevicePro12p9InchiPad),
                                   @"iPad6,11":@(UIDevice5GiPad),
                                   @"iPad6,12":@(UIDevice5GiPad),
                                   @"iPad7,3":@(UIDevicePro10p5InchiPad),
                                   @"iPad7,4":@(UIDevicePro10p5InchiPad),
                                   @"iPad7,1":@(UIDevicePro12p9Inch2GiPad),
                                   @"iPad7,2":@(UIDevicePro12p9Inch2GiPad),
                                   @"iPad7,5":@(UIDevice6GiPad),
                                   @"iPad7,6":@(UIDevice6GiPad),
                                   @"iPad8,1":@(UIDevicePro11InchiPad),
                                   @"iPad8,2":@(UIDevicePro11InchiPad),
                                   @"iPad8,3":@(UIDevicePro11InchiPad),
                                   @"iPad8,4":@(UIDevicePro11InchiPad),
                                   @"iPad8,5":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,6":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,7":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,8":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad11,3":@(UIDeviceAir3GiPad),
                                   @"iPad11,4":@(UIDeviceAir3GiPad),
                                   @"iPad7,11":@(UIDevice7GiPad),
                                   @"iPad7,12":@(UIDevice7GiPad),
                                   @"iPad8,9":@(UIDevicePro11Inch2GiPad),
                                   @"iPad8,10":@(UIDevicePro11Inch2GiPad),
                                   @"iPad8,11":@(UIDevicePro12p9Inch4GiPad),
                                   @"iPad8,12":@(UIDevicePro12p9Inch4GiPad),
                                   @"iPad11,6":@(UIDevice8GiPad),
                                   @"iPad11,7":@(UIDevice8GiPad),
                                   @"iPad12,1":@(UIDevice10p2Inch9thPad),
                                   @"iPad12,2":@(UIDevice10p2Inch9thPad),
                                   @"iPad13,1":@(UIDeviceAir4GiPad),
                                   @"iPad13,2":@(UIDeviceAir4GiPad),
                                   @"iPad13,4":@(UIDevicePro11Inch3rdPad),
                                   @"iPad13,5":@(UIDevicePro11Inch3rdPad),
                                   @"iPad13,6":@(UIDevicePro11Inch3rdPad),
                                   @"iPad13,7":@(UIDevicePro11Inch3rdPad),
                                   @"iPad13,8":@(UIDevicePro12p9Inch5thPad),
                                   @"iPad13,9":@(UIDevicePro12p9Inch5thPad),
                                   @"iPad13,10":@(UIDevicePro12p9Inch5thPad),
                                   @"iPad13,11":@(UIDevicePro12p9Inch5thPad),
                                   @"iPad14,1":@(UIDeviceiPadmini6th),
                                   @"iPad14,2":@(UIDeviceiPadmini6th),
                                   @"iPad2,5":@(UIDeviceiPadmini),
                                   @"iPad2,6":@(UIDeviceiPadmini),
                                   @"iPad2,7":@(UIDeviceiPadmini),
                                   @"iPad4,4":@(UIDeviceiPadminiRetina),
                                   @"iPad4,5":@(UIDeviceiPadminiRetina),
                                   @"iPad4,6":@(UIDeviceiPadminiRetina),
                                   @"iPad4,7":@(UIDeviceiPadmini3),
                                   @"iPad4,8":@(UIDeviceiPadmini3),
                                   @"iPad4,9":@(UIDeviceiPadmini3),
                                   @"iPad5,1":@(UIDeviceiPadmini4),
                                   @"iPad5,2":@(UIDeviceiPadmini4),
                                   @"iPad11,1":@(UIDeviceiPadmini5G),
                                   @"iPad11,2":@(UIDeviceiPadmini5G),
                  };
    return ipadInforDic;
}

- (NSDictionary *)platFormAppleTVInforDic {
    NSDictionary *appleTVInforDic = @{@"AppleTV2,1":@(UIDeviceAppleTV2),
                                      @"AppleTV3,1":@(UIDeviceAppleTV3),
                                      @"AppleTV3,2":@(UIDeviceAppleTV3),
                                      @"AppleTV5,3":@(UIDeviceAppleTV4),
                                      @"AppleTV6,2":@(UIDeviceAppleTV4K),
                };
    return appleTVInforDic;
}

- (UIDevicePlatform)platformType
{
    static UIDevicePlatform devicePlatform = UIDeviceUnknown;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        NSString *platform = [self platform];
        if ([platform isEqualToString:@"iFPGA"])        devicePlatform = UIDeviceIFPGA;
        
        NSDictionary *inforDic = nil;
        if ([platform hasPrefix:@"iPhone"]) {
            inforDic = [self platFormIphoneInforDic];
        } else if ([platform hasPrefix:@"iPod"]) {
            inforDic = [self platFormiPodInforDic];
        } else if ([platform hasPrefix:@"iPad"]) {
            inforDic = [self platFormiPadInforDic];
        } else if ([platform hasPrefix:@"AppleTV"]) {
            inforDic = [self platFormAppleTVInforDic];
        }
        NSNumber *type = [inforDic objectForKey:platform];
        if (type) {
            devicePlatform = type.integerValue;
        } else {
            if ([platform hasPrefix:@"iPhone"])             devicePlatform = UIDeviceUnknowniPhone;
            if ([platform hasPrefix:@"iPod"])               devicePlatform = UIDeviceUnknowniPod;
            if ([platform hasPrefix:@"iPad"])               devicePlatform = UIDeviceUnknowniPad;
            // Simulator thanks Jordan Breeding
            if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
                BOOL smallerScreen = MIN([UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.height) < 768;
                devicePlatform = smallerScreen ? UIDeviceiPhoneSimulatoriPhone : UIDeviceiPhoneSimulatoriPad;
            }
        }
    });
    return devicePlatform;
}

- (NSString *)platformString
{
    static NSString *platStr = nil;
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        switch ([self platformType]) {
            case UIDevice1GiPhone: platStr = IPHONE_1G_NAMESTRING; break;
            case UIDevice3GiPhone: platStr = IPHONE_3G_NAMESTRING; break;
            case UIDevice3GSiPhone: platStr = IPHONE_3GS_NAMESTRING; break;
            case UIDevice4iPhone: platStr = IPHONE_4_NAMESTRING; break;
            case UIDevice4SiPhone: platStr = IPHONE_4S_NAMESTRING; break;
            case UIDevice5iPhone: platStr = IPHONE_5_NAMESTRING; break;
            case UIDevice5CiPhone: platStr = IPHONE_5C_NAMESTRING; break;
            case UIDevice5SiPhone: platStr = IPHONE_5S_NAMESTRING; break;
            case UIDevice6iPhone: platStr = IPHONE_6_NAMESTRING; break;
            case UIDevice6PlusiPhone: platStr = IPHONE_6PLUS_NAMESTRING; break;
            case UIDevice6SiPhone: platStr = IPHONE_6S_NAMESTRING; break;
            case UIDevice6SPlusiPhone: platStr = IPHONE_6SPLUS_NAMESTRING; break;
            case UIDeviceSEiPhone: platStr = IPHONE_SE_NAMESTRING; break;
            case UIDevice7iPhone: platStr = IPHONE_7_NAMESTRING; break;
            case UIDevice7PlusiPhone: platStr = IPHONE_7PLUS_NAMESTRING; break;
            case UIDevice8iPhone: platStr = IPHONE_8_NAMESTRING; break;
            case UIDevice8PlusiPhone: platStr = IPHONE_8PLUS_NAMESTRING; break;
            case UIDeviceXiPhone: platStr = IPHONE_X_NAMESTRING; break;
            case UIDeviceXSiPhone: platStr = IPHONE_XS_NAMESTRING; break;
            case UIDeviceXSMaxiPhone: platStr = IPHONE_XSMAX_NAMESTRING; break;
            case UIDeviceXRiPhone: platStr = IPHONE_XR_NAMESTRING; break;
            case UIDevice11iPhone: platStr = IPHONE_11_NAMESTRING; break;
            case UIDevice11ProiPhone: platStr = IPHONE_11PRO_NAMESTRING; break;
            case UIDevice11ProMaxiPhone: platStr = IPHONE_11PROMAX_NAMESTRING; break;
            case UIDeviceSE2GiPhone: platStr = IPHONE_SE2G_NAMESTRING; break;
            case UIDevice12miniiPhone: platStr = IPHONE_12MINI_NAMESTRING; break;
            case UIDevice12iPhone: platStr = IPHONE_12_NAMESTRING; break;
            case UIDevice12ProiPhone: platStr = IPHONE_12PRO_NAMESTRING; break;
            case UIDevice12ProMaxiPhone: platStr = IPHONE_12PROMAX_NAMESTRING; break;
            // iPhone 13
            case UIDevice13miniiPhone: platStr = IPHONE_13MINI_NAMESTRING; break;
            case UIDevice13iPhone: platStr = IPHONE_13_NAMESTRING; break;
            case UIDevice13ProiPhone: platStr = IPHONE_13PRO_NAMESTRING; break;
            case UIDevice13ProMaxiPhone: platStr = IPHONE_13PROMAX_NAMESTRING; break;
            
            case UIDeviceUnknowniPhone: platStr = IPHONE_UNKNOWN_NAMESTRING; break;
                
            case UIDevice1GiPod: platStr = IPOD_1G_NAMESTRING; break;
            case UIDevice2GiPod: platStr = IPOD_2G_NAMESTRING; break;
            case UIDevice3GiPod: platStr = IPOD_3G_NAMESTRING; break;
            case UIDevice4GiPod: platStr = IPOD_4G_NAMESTRING; break;
            case UIDevice5GiPod: platStr = IPOD_5G_NAMESTRING; break;
            case UIDevice6GiPod: platStr = IPOD_6G_NAMESTRING; break;
            case UIDevice7GiPod: platStr = IPOD_7G_NAMESTRING; break;
            case UIDeviceUnknowniPod: platStr = IPOD_UNKNOWN_NAMESTRING; break;
                
            case UIDevice1GiPad: platStr = IPAD_1G_NAMESTRING; break;
            case UIDevice2GiPad: platStr = IPAD_2G_NAMESTRING; break;
            case UIDevice3GiPad: platStr = IPAD_3G_NAMESTRING; break;
            case UIDevice4GiPad: platStr = IPAD_4G_NAMESTRING; break;
            case UIDeviceAiriPad: platStr = IPAD_AIR_NAMESTRING; break;
            case UIDeviceAir2iPad: platStr = IPAD_AIR2_NAMESTRING; break;
            case UIDevicePro9p7InchiPad: platStr = IPAD_PRO9P7INCH_NAMESTRING; break;
            case UIDevicePro12p9InchiPad: platStr = IPAD_PRO12P9INCH_NAMESTRING; break;
            case UIDevice5GiPad: platStr = IPAD_5G_NAMESTRING; break;
            case UIDevicePro10p5InchiPad: platStr = IPAD_PRO10P5INCH_NAMESTRING; break;
            case UIDevicePro12p9Inch2GiPad: platStr = IPAD_PRO12P9INCH2G_NAMESTRING; break;
            case UIDevice6GiPad: platStr = IPAD_6G_NAMESTRING; break;
            case UIDevicePro11InchiPad: platStr = IPAD_PRO11INCH_NAMESTRING; break;
            case UIDevicePro12p9Inch3GiPad: platStr = IPAD_PRO12P9INCH3G_NAMESTRING; break;
            case UIDeviceAir3GiPad: platStr = IPAD_AIR3G_NAMESTRING; break;
            case UIDevice7GiPad: platStr = IPAD_7G_NAMESTRING; break;
            case UIDevicePro11Inch2GiPad: platStr = IPAD_PRO11INCH2G_NAMESTRING; break;
            case UIDevicePro12p9Inch4GiPad: platStr = IPAD_PRO12P9INCH4G_NAMESTRING; break;
            case UIDevice8GiPad: platStr = IPAD_8G_NAMESTRING; break;
            case UIDeviceAir4GiPad: platStr = IPAD_AIR4G_NAMESTRING; break;
                
            case UIDeviceiPadmini: platStr = IPAD_MINI_NAMESTRING; break;
            case UIDeviceiPadminiRetina: platStr = IPAD_MINI_RETINA_NAMESTRING; break;
            case UIDeviceiPadmini3: platStr = IPAD_MINI3_NAMESTRING; break;
            case UIDeviceiPadmini4: platStr = IPAD_MINI4_NAMESTRING; break;
            case UIDeviceiPadmini5G: platStr = IPAD_MINI5G_NAMESTRING; break;
            case UIDeviceUnknowniPad: platStr = IPAD_UNKNOWN_NAMESTRING; break;
            
            case UIDevicePro12p9Inch5thPad: platStr = IPAD_PRO12P9INCH5TH_NAMESTRING; break;
            case UIDevicePro11Inch3rdPad: platStr = IPAD_PRO11INCH3RD_NAMESTRING; break;
            case UIDevice10p2Inch9thPad: platStr = IPAD_10P2INCH9TH_NAMESTRING; break;
            case UIDeviceiPadmini6th: platStr = IPAD_MINI6_NAMESTRING; break;
                
            case UIDeviceAppleTV2: platStr = APPLETV_2G_NAMESTRING; break;
            case UIDeviceAppleTV3: platStr = APPLETV_3G_NAMESTRING; break;
            case UIDeviceAppleTV4: platStr = APPLETV_4G_NAMESTRING; break;
            case UIDeviceAppleTV4K: platStr = APPLETV_4K_NAMESTRING; break;
            case UIDeviceUnknownAppleTV: platStr = APPLETV_UNKNOWN_NAMESTRING; break;
                
            case UIDeviceiPhoneSimulator: platStr = IPHONE_SIMULATOR_NAMESTRING; break;
            case UIDeviceiPhoneSimulatoriPhone: platStr = IPHONE_SIMULATOR_IPHONE_NAMESTRING; break;
            case UIDeviceiPhoneSimulatoriPad: platStr = IPHONE_SIMULATOR_IPAD_NAMESTRING; break;
                
            case UIDeviceIFPGA: platStr = IFPGA_NAMESTRING; break;
                
            default: platStr = IOS_FAMILY_UNKNOWN_DEVICE; break;
        }
    });
    return platStr;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
- (NSString *)macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)osLanguageAndCountry
{
    NSString *locale = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLocale"];
    return locale;
}

- (BOOL)isIphoneGreaterOrEqualDevicePlatform:(UIDevicePlatform)devicePlatform
{
    NSString *platform = [[UIDevice currentDevice] platform];
    if ([platform hasPrefix:@"iPhone"]) {
        if ([[UIDevice currentDevice] platformType] >= devicePlatform) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isIphoneLessOrEqualDevicePlatform:(UIDevicePlatform)devicePlatform
{
    NSString *platform = [[UIDevice currentDevice] platform];
    if ([platform hasPrefix:@"iPhone"]) {
        if ([[UIDevice currentDevice] platformType] <= devicePlatform) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isIPhoneX
{
    static BOOL x = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        float statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            if (statusHeight > 20) {
                x = YES;
            } else {
                x = NO;
            }
    });
    return x;
}

@end
