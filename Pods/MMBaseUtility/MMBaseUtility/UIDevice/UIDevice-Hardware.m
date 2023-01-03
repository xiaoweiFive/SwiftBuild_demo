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
    static NSString *platform;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platform = [self getSysInfoByName:"hw.machine"];
    });
    return platform;
}

- (NSString *)hwmodel
{
    static NSString *hwmodel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hwmodel = [self getSysInfoByName:"hw.model"];
    });
    return hwmodel;
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
    static NSUInteger cpuFrequence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cpuFrequence = [self getSysInfo:HW_CPU_FREQ];
    });
    
    return cpuFrequence;
}

- (NSUInteger)busFrequency
{
    static NSUInteger busFrequency;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        busFrequency = [self getSysInfo:HW_BUS_FREQ];
    });
    
    return busFrequency;
}

- (NSUInteger)totalMemory
{
    static NSUInteger totalMemory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        totalMemory = [self getSysInfo:HW_PHYSMEM];
    });
    return totalMemory;
}

- (NSUInteger)userMemory
{
    static NSUInteger userMemory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userMemory = [self getSysInfo:HW_USERMEM];
    });
    return userMemory;
}

- (NSUInteger)maxSocketBufferSize
{
    static NSUInteger maxSocketBufferSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        maxSocketBufferSize = [self getSysInfo:KIPC_MAXSOCKBUF];
    });
    return maxSocketBufferSize;
}

#pragma mark file system -- Thanks Joachim Bean!
- (NSNumber *)totalDiskSpace
{
    static NSNumber *totalDiskSpace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
        totalDiskSpace = [fattributes objectForKey:NSFileSystemSize];
    });
    return totalDiskSpace;
}

- (NSNumber *)freeDiskSpace
{
    static NSNumber *freeDiskSpace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
        freeDiskSpace = [fattributes objectForKey:NSFileSystemFreeSize];
    });
    return freeDiskSpace;
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
                                     @"iPhone14,6":@(UIDeviceSE3rdGen),// iPhone SE 3rd Gen
                                     @"iPhone14,7":@(UIDevice14iPhone),// iPhone 14
                                     @"iPhone14,8":@(UIDevice14PlusiPhone),// iPhone 14 Plus
                                     @"iPhone15,2":@(UIDevice14ProIPhone),// iPhone 14 Pro
                                     @"iPhone15,3":@(UIDevice14ProMaxiPhone)// iPhone 14 Pro Max
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
                                   @"iPad2,5":@(UIDeviceiPadmini),
                                   @"iPad2,6":@(UIDeviceiPadmini),
                                   @"iPad2,7":@(UIDeviceiPadmini),
                                   @"iPad3,1":@(UIDevice3GiPad),
                                   @"iPad3,2":@(UIDevice3GiPad),
                                   @"iPad3,3":@(UIDevice3GiPad),
                                   @"iPad3,4":@(UIDevice4GiPad),
                                   @"iPad3,5":@(UIDevice4GiPad),
                                   @"iPad3,6":@(UIDevice4GiPad),
                                   @"iPad4,1":@(UIDeviceAiriPad),
                                   @"iPad4,2":@(UIDeviceAiriPad),
                                   @"iPad4,3":@(UIDeviceAiriPad),
                                   @"iPad4,4":@(UIDeviceiPadminiRetina),
                                   @"iPad4,5":@(UIDeviceiPadminiRetina),
                                   @"iPad4,6":@(UIDeviceiPadminiRetina),
                                   @"iPad4,7":@(UIDeviceiPadmini3),
                                   @"iPad4,8":@(UIDeviceiPadmini3),
                                   @"iPad4,9":@(UIDeviceiPadmini3),
                                   @"iPad5,1":@(UIDeviceiPadmini4),
                                   @"iPad5,2":@(UIDeviceiPadmini4),
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
                                   @"iPad7,11":@(UIDevice7GiPad),
                                   @"iPad7,12":@(UIDevice7GiPad),
                                   @"iPad8,1":@(UIDevicePro11InchiPad),
                                   @"iPad8,2":@(UIDevicePro11InchiPad),
                                   @"iPad8,3":@(UIDevicePro11InchiPad),
                                   @"iPad8,4":@(UIDevicePro11InchiPad),
                                   @"iPad8,5":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,6":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,7":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,8":@(UIDevicePro12p9Inch3GiPad),
                                   @"iPad8,9":@(UIDevicePro11Inch2GiPad),
                                   @"iPad8,10":@(UIDevicePro11Inch2GiPad),
                                   @"iPad8,11":@(UIDevicePro12p9Inch4GiPad),
                                   @"iPad8,12":@(UIDevicePro12p9Inch4GiPad),
                                   @"iPad11,1":@(UIDeviceiPadmini5G),
                                   @"iPad11,2":@(UIDeviceiPadmini5G),
                                   @"iPad11,3":@(UIDeviceAir3GiPad),
                                   @"iPad11,4":@(UIDeviceAir3GiPad),
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
                                   @"iPad13,16":@(UIDeviceAir5thGenWiFi),
                                   @"iPad13,17":@(UIDeviceAir5thGenWIFICellular),
                                   @"iPad14,1":@(UIDeviceiPadmini6th),
                                   @"iPad14,2":@(UIDeviceiPadmini6th),
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
            devicePlatform = UIDeviceUnknowniPhone;
        } else if ([platform hasPrefix:@"iPod"]) {
            inforDic = [self platFormiPodInforDic];
            devicePlatform = UIDeviceUnknowniPod;
        } else if ([platform hasPrefix:@"iPad"]) {
            inforDic = [self platFormiPadInforDic];
            devicePlatform = UIDeviceUnknowniPad;
        } else if ([platform hasPrefix:@"AppleTV"]) {
            inforDic = [self platFormAppleTVInforDic];
        }
        NSNumber *type = [inforDic objectForKey:platform];
        if (type) {
            devicePlatform = type.integerValue;
        } else {
            // Simulator thanks Jordan Breeding
            if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"] || [platform isEqual:@"arm64"]) {
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
        NSString *platform = [self platform];
        NSDictionary *map = [self deviceMap];
        platStr = map[platform];
        if (!platStr) {
            platStr = platform;
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

#warning - 设备名只能新增不能移除或修改，否则可能造成对应设备出现账号被踢问题
#warning - 设备名只能新增不能移除或修改，否则可能造成对应设备出现账号被踢问题
#warning - 设备名只能新增不能移除或修改，否则可能造成对应设备出现账号被踢问题

- (NSDictionary *)deviceMap {
    NSDictionary *dic = @{
        @"i386" : @"iPhone Simulator",
        @"x86_64" : @"iPhone Simulator",
        @"arm64" : @"iPhone Simulator",
//        @"iPhone1,1" : @"iPhone 1G",
//        @"iPhone1,2" : @"iPhone 3G",
//        @"iPhone2,1" : @"iPhone 3GS",
//        @"iPhone3,1" : @"iPhone 4",
//        @"iPhone3,2" : @"iPhone 4",
//        @"iPhone3,3" : @"iPhone 4",
//        @"iPhone4,1" : @"iPhone 4S",
//        @"iPhone5,1" : @"iPhone 5",
//        @"iPhone5,2" : @"iPhone 5",
//        @"iPhone5,3" : @"iPhone 5C",
//        @"iPhone5,4" : @"iPhone 5C",      // 设备不再支持iOS 12
        @"iPhone6,1" : @"iPhone 5S",
        @"iPhone6,2" : @"iPhone 5S",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone8,1" : @"iPhone 6S",
        @"iPhone8,2" : @"iPhone 6S Plus",
        @"iPhone8,4" : @"iPhone SE",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone11,2" : @"iPhone XS",
        @"iPhone11,4" : @"iPhone XS Max",
        @"iPhone11,6" : @"iPhone XS Max",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        @"iPhone12,8" : @"iPhone SE 2G",
        @"iPhone13,1" : @"iPhone 12 Mini",
        @"iPhone13,2" : @"iPhone 12",
        @"iPhone13,3" : @"iPhone 12 Pro",
        @"iPhone13,4" : @"iPhone 12 Pro Max",
        @"iPhone14,2" : @"iPhone 13 Pro",
        @"iPhone14,3" : @"iPhone 13 Pro Max",
        @"iPhone14,4" : @"iPhone 13 Mini",
        @"iPhone14,5" : @"iPhone 13",
        @"iPhone14,6" : @"iPhone SE 3G",
        @"iPhone14,7" : @"iPhone 14",
        @"iPhone14,8" : @"iPhone 14 Plus",
        @"iPhone15,2" : @"iPhone 14 Pro",
        @"iPhone15,3" : @"iPhone 14 Pro Max",
        
//        @"iPod1,1" : @"iPod touch 1Gen",
//        @"iPod2,1" : @"iPod touch 2Gen",
//        @"iPod3,1" : @"iPod touch 3Gen",
//        @"iPod4,1" : @"iPod touch 4Gen",
//        @"iPod5,1" : @"iPod touch 5Gen",      // 不再支持iOS 12
        @"iPod7,1" : @"iPod touch 6Gen",
        @"iPod9,1" : @"iPod touch 7Gen",
        
//        @"iPad1,1" : @"iPad 1G",
//        @"iPad1,2" : @"iPad 3G",
        @"iPad2,1" : @"iPad 2G",
        @"iPad2,2" : @"iPad 2G",
        @"iPad2,3" : @"iPad 2G",
        @"iPad2,4" : @"iPad 2G",
        @"iPad2,5" : @"iPad mini",
        @"iPad2,6" : @"iPad mini",
        @"iPad2,7" : @"iPad mini",
        @"iPad3,1" : @"iPad 3G",
        @"iPad3,2" : @"iPad 3G",
        @"iPad3,3" : @"iPad 3G",
        @"iPad3,4" : @"iPad 4G",
        @"iPad3,5" : @"iPad 4G",
        @"iPad3,6" : @"iPad 4G",
        @"iPad4,1" : @"iPad Air",
        @"iPad4,2" : @"iPad Air",
        @"iPad4,3" : @"iPad Air",
        @"iPad4,4" : @"iPad mini Retina",
        @"iPad4,5" : @"iPad mini Retina",
        @"iPad4,6" : @"iPad mini Retina",
        @"iPad4,7" : @"iPad mini 3",
        @"iPad4,8" : @"iPad mini 3",
        @"iPad4,9" : @"iPad mini 3",
        @"iPad5,1" : @"iPad mini 4",
        @"iPad5,2" : @"iPad mini 4",
        @"iPad5,3" : @"iPad Air 2",
        @"iPad5,4" : @"iPad Air 2",
        @"iPad6,3" : @"iPad Pro 9.7-inch",
        @"iPad6,4" : @"iPad Pro 9.7-inch",
        @"iPad6,7" : @"iPad Pro 12.9-inch",
        @"iPad6,8" : @"iPad Pro 12.9-inch",
        @"iPad6,11" : @"iPad 5G",
        @"iPad6,12" : @"iPad 5G",
        @"iPad7,1" : @"iPad Pro 12.9-inch 2G",
        @"iPad7,2" : @"iPad Pro 12.9-inch 2G",
        @"iPad7,3" : @"iPad Pro 10.5-inch",
        @"iPad7,4" : @"iPad Pro 10.5-inch",
        @"iPad7,5" : @"iPad 6G",
        @"iPad7,6" : @"iPad 6G",
        @"iPad7,11" : @"iPad 7G",
        @"iPad7,12" : @"iPad 7G",
        @"iPad8,1" : @"iPad Pro 11-inch",
        @"iPad8,2" : @"iPad Pro 11-inch",
        @"iPad8,3" : @"iPad Pro 11-inch",
        @"iPad8,4" : @"iPad Pro 11-inch",
        @"iPad8,5" : @"iPad Pro 12.9-inch 3G",
        @"iPad8,6" : @"iPad Pro 12.9-inch 3G",
        @"iPad8,7" : @"iPad Pro 12.9-inch 3G",
        @"iPad8,8" : @"iPad Pro 12.9-inch 3G",
        @"iPad8,9" : @"iPad Pro 11-inch 2G",
        @"iPad8,10" : @"iPad Pro 11-inch 2G",
        @"iPad8,11" : @"iPad Pro 12.9-inch 4G",
        @"iPad8,12" : @"iPad Pro 12.9-inch 4G",
        @"iPad11,1" : @"iPad mini 5G",
        @"iPad11,2" : @"iPad mini 5G",
        @"iPad11,3" : @"iPad Air 3G",
        @"iPad11,4" : @"iPad Air 3G",
        @"iPad11,6" : @"iPad 8G",
        @"iPad11,7" : @"iPad 8G",
        @"iPad12,1" : @"iPad Pro 10.2-inch 9th",
        @"iPad12,2" : @"iPad Pro 10.2-inch 9th",
        @"iPad13,1" : @"iPad Air 4G",
        @"iPad13,2" : @"iPad Air 4G",
        @"iPad13,4" : @"iPad Pro 11-inch 3rd",  // 5th
        @"iPad13,5" : @"iPad Pro 11-inch 3rd",  // 5th
        @"iPad13,6" : @"iPad Pro 11-inch 3rd",  // 5th
        @"iPad13,7" : @"iPad Pro 11-inch 3rd",  // 5th
        @"iPad13,8" : @"iPad Pro 12.9-inch 5th",
        @"iPad13,9" : @"iPad Pro 12.9-inch 5th",
        @"iPad13,10" : @"iPad Pro 12.9-inch 5th",
        @"iPad13,11" : @"iPad Pro 12.9-inch 5th",
        @"iPad13,16" : @"iPad Air 5G",
        @"iPad13,17" : @"iPad Air 5Gen",
        @"iPad14,1" : @"iPad mini 6",
        @"iPad14,2" : @"iPad mini 6",
    };
    return dic;
}


@end
