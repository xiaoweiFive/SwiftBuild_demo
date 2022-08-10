//
//  MFInetAddress.h
//  MomoChat
//
//  Created by Latermoon on 12-9-11.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, APSource) {
    APSource_DefaultDomain = 1,//默认域名（ap.immomo.com）
    APSource_RefereeDomain = 2,//referee切换后拿到的域名，
    APSource_RefereeIP = 3,//referee切换后拿到的ip
    APSource_CachedIP = 4,// 使用的是本地缓存ip地址
    APSource_CachedDomain = 5,// 使用的是本地缓存的域名
    APSource_AuthedAP = 6, // auth返回的ap
    APSource_ServeredAP = 7, // discon 410 ap
    APSource_HttpDNS    = 8
};
/**
 * 把Host和Port包装起来，便于传递和存储
 */
@interface MFInetAddress : NSObject

#pragma mark Host and Port
@property (copy, nonatomic)                NSString *host;
@property (nonatomic) NSInteger              port;
@property (nonatomic) APSource               apSource;
@property (nonatomic) BOOL                   isIPV6;
@property (nonatomic) NSUInteger             index;
@property (nonatomic, retain) NSError        *error;

@property (nonatomic) CFTimeInterval         startTime;
@property (nonatomic) CFTimeInterval         endTime;

#pragma mark Init
+ (MFInetAddress *)addressWithHost:(NSString *)aHost andPort:(NSInteger)aPort;
- (MFInetAddress *)initWithHost:(NSString *)aHost andPort:(NSInteger)aPort;

@end
