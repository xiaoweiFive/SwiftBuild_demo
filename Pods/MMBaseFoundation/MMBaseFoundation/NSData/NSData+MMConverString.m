//
//  NSData+MMConverString.m
//  MMBaseFoundationDemo
//
//  Created by yzkmac on 2020/3/17.
//  Copyright © 2020 yzkmac. All rights reserved.
//

#import "NSData+MMConverString.h"

@implementation NSData (MMConverString)

- (NSString *)mm_hexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    if (!dataBuffer) {
        return @"";
    }
    NSUInteger dataLength  = [self length];
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }
    return [NSString stringWithString:hexString];
}

@end
