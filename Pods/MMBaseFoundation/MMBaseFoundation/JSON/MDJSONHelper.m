//
//  MDJSONHelper.m
//  MomoChat
//
//  Created by yupengzhang on 15/3/6.
//  Copyright (c) 2015年 wemomo.com. All rights reserved.
//

#import "MDJSONHelper.h"

@implementation NSDictionary (MDJSONHelper)

- (NSString *)MDJSONString {
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self] ? [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil] : nil;
    NSString *jsonString = @"{}";
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *)MDJSON2String {
    return [self MDJSONString];
}

- (NSString *)MDJSON2StringNilOptions {
    return [self MDJSONString];
}

- (NSString *)MDJSONStringNOPrettyPrinted {
    return [self MDJSONString];
}

- (NSString *)MDJSONStringWithPrettyPrinted {
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self] ? [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] : nil;
    NSString *jsonString = @"{}";
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSData *)MDJSONData {
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self] ? [NSJSONSerialization dataWithJSONObject:self options:0 error:nil] : nil;
    return jsonData;
}

@end

@implementation NSArray (MDJSONHelper)

- (NSString *)MDJSONString
{
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self]?[NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil]:nil;
    NSString *jsonString = @"[]";
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *)MDJSON2String {
    return [self MDJSONString];
}

- (NSString *)MDJSON2StringNilOptions {
    return [self MDJSONString];
}

- (NSString *)MDJSONStringNOPrettyPrinted {
    return [self MDJSONString];
}

- (NSString *)MDJSONStringWithPrettyPrinted {
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self] ? [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] : nil;
    NSString *jsonString = @"[]";
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSData *)MDJSONData {
    NSData *jsonData = [NSJSONSerialization isValidJSONObject:self] ? [NSJSONSerialization dataWithJSONObject:self options:0 error:nil] : nil;
    return jsonData;
}

@end

@implementation NSString (MDJSONHelper)

- (id)objectFromJSONString {
    NSData *dataString = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = nil;
    if (dataString) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:dataString options:NSJSONReadingMutableContainers error:nil];
    }
    return jsonObject;
}

- (id)objectFromMDJSONString {
    return [self objectFromJSONString];
}

@end

@implementation NSData (MDJSONHelper)

- (id)objectFromJSONData {
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
    return jsonObject;
}

@end
