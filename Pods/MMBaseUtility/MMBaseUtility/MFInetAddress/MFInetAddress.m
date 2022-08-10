//
//  MFInetAddress.m
//  MomoChat
//
//  Created by Latermoon on 12-9-11.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "MFInetAddress.h"

@implementation MFInetAddress

+ (MFInetAddress *)addressWithHost:(NSString *)aHost andPort:(NSInteger)aPort
{
    return [[MFInetAddress alloc] initWithHost:aHost andPort:aPort];
}

- (MFInetAddress *)initWithHost:(NSString *)aHost andPort:(NSInteger)aPort
{
    self = [super init];
    if (self) {
        _host = aHost;
        _port = aPort;
    }
    return self;
}

- (NSString *)description
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.host forKey:@"host"];
    [dict setValue:[NSNumber numberWithInteger:self.port] forKey:@"port"];
    
    [dict setValue:@(self.index) forKey:@"index"];
    [dict setValue:@(self.apSource) forKey:@"apsource"];
    CFTimeInterval last = self.endTime - self.startTime;
    if (last > 0.000001) {
        [dict setValue:@(last) forKey:@"lastTime"];
    }
    
    if (self.error) {
        [dict setValue:self.error.localizedDescription forKey:@"failedErrorInfo"];
    }
    
    return [dict description];
}

@end
