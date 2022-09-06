//
//  NSDictionary+Safe.m
//  MMBaseFoundationDemo
//
//  Created by yzkmac on 2020/3/16.
//  Copyright © 2020 yzkmac. All rights reserved.
//

#import "NSDictionary+MMSafe.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSDictionary (MMSafe)

#pragma mark - sefe hook


#pragma mark - 类方法

+ (nullable id)dictionary:(NSDictionary *)dict objectForKey:(NSString *)aKey defaultValue:(nullable id)value
{
    if (!dict) {
        return value;
    }
    return [dict objectForKey:aKey defaultValue:value];
}

+ (nullable NSString *)dictionary:(NSDictionary *)dict stringForKey:(NSString *)aKey defaultValue:(nullable NSString *)value
{
    if (!dict) {
        return value;
    }
    return [dict stringForKey:aKey defaultValue:value];
}

+ (nullable NSArray *)dictionary:(NSDictionary *)dict arrayForKey:(NSString *)aKey defaultValue:(nullable NSArray *)value
{
    if (!dict) {
        return value;
    }
    return [dict arrayForKey:aKey defaultValue:value];
}

+ (nullable NSDictionary *)dictionary:(NSDictionary *)dict dictionaryForKey:(NSString *)aKey defaultValue:(nullable NSDictionary *)value
{
    if (!dict) {
        return value;
    }
    return [dict dictionaryForKey:aKey defaultValue:value];
}

+ (nullable NSData *)dictionary:(NSDictionary *)dict dataForKey:(NSString *)aKey defaultValue:(nullable NSData *)value
{
    if (!dict) {
        return value;
    }
    return [dict dataForKey:aKey defaultValue:value];
}

+ (nullable NSDate *)dictionary:(NSDictionary *)dict dateForKey:(NSString *)aKey defaultValue:(nullable NSDate *)value
{
    if (!dict) {
        return value;
    }
    return [dict dateForKey:aKey defaultValue:value];
}

+ (nullable NSNumber *)dictionary:(NSDictionary *)dict numberForKey:(NSString *)aKey defaultValue:(nullable NSNumber *)value
{
    if (!dict) {
        return value;
    }
    return [dict numberForKey:aKey defaultValue:value];
}

+ (NSUInteger)dictionary:(NSDictionary *)dict unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value
{
    if (!dict) {
        return value;
    }
    return [dict unsignedIntegerForKey:aKey defaultValue:value];
}

+ (NSInteger)dictionary:(NSDictionary *)dict integerForKey:(NSString *)aKey defaultValue:(NSInteger)value
{
    if (!dict) {
        return value;
    }
    return [dict integerForKey:aKey defaultValue:value];
}

+ (float)dictionary:(NSDictionary *)dict floatForKey:(NSString *)aKey defaultValue:(float)value
{
    if (!dict) {
        return value;
    }
    return [dict floatForKey:aKey defaultValue:value];
}

+ (double)dictionary:(NSDictionary *)dict doubleForKey:(NSString *)aKey defaultValue:(double)value
{
    if (!dict) {
        return value;
    }
    return [dict doubleForKey:aKey defaultValue:value];
}

+ (long long)dictionary:(NSDictionary *)dict longLongValueForKey:(NSString *)aKey defaultValue:(long long)value
{
    if (!dict) {
        return value;
    }
    return [dict longLongValueForKey:aKey defaultValue:value];
}

+ (BOOL)dictionary:(NSDictionary *)dict boolForKey:(NSString *)aKey defaultValue:(BOOL)value
{
    if (!dict) {
        return value;
    }
    return [dict boolForKey:aKey defaultValue:value];
}

+ (int)dictionary:(NSDictionary *)dict intForKey:(NSString *)aKey defaultValue:(int)value
{
    if (!dict) {
        return value;
    }
    return [dict intForKey:aKey defaultValue:value];
}

@end

@implementation NSMutableDictionary (MMSafe)

+(void)load {
#ifdef DISTRIBUTION
    [objc_getClass("__NSDictionaryM") swizzleInstanceSelector:@selector(setObject:forKey:) withNewSelector:@selector(md_overrideSetObject:forKey:)];
    [objc_getClass("__NSDictionaryM") swizzleInstanceSelector:@selector(removeObjectForKey:) withNewSelector:@selector(md_overrideRemoveObjectForKey:)];
#endif
}

- (void)md_overrideSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject || !aKey ) {
        return;
    }
    [self md_overrideSetObject:anObject forKey:aKey];
}

- (void)md_overrideRemoveObjectForKey:(id)aKey {
    if (!aKey) {
        return;
    }
    
    [self md_overrideRemoveObjectForKey:aKey];
}

@end

@implementation NSUserDefaults (MMSafe)
@end

@implementation NSMapTable (MMSafe)
@end

@implementation NSCache (MMSafe)
// fix crash: https://cosmos-compass-web.immomo.com/apm/crash/classifyDetail?crashId=522332&searchTime=2&rifleCategory=&isNew=0&appId=26e61d33cefc4e2cab629715b6aa260f_2&theme=%E5%B4%A9%E6%BA%83&_bid=0

+ (void)load {
#ifdef DISTRIBUTION
    [self swizzleInstanceSelector:@selector(setObject:forKey:) withNewSelector:@selector(md_safeSetObject:forKey:)];
    [self swizzleInstanceSelector:@selector(setObject:forKey:cost:) withNewSelector:@selector(md_safeSetObject:forKey:cost:)];
#endif
}

- (void)md_safeSetObject:(id)obj forKey:(id)key {
    if (obj) {
        [self md_safeSetObject:obj forKey:key];
    } else {
        [self removeObjectForKey:key];
    }
}

- (void)md_safeSetObject:(id)obj forKey:(id)key cost:(NSUInteger)g {
    if (obj) {
        [self md_safeSetObject:obj forKey:key cost:g];
    } else {
        [self removeObjectForKey:key];
    }
}

@end
