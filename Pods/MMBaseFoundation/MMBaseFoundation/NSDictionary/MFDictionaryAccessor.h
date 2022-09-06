//
//  MFDictionaryAccessor.h
//  MomoChat
//
//  Created by Latermoon on 12-9-16.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 实现该协议的类，可以使用MFDictionaryAdapter系列方法增强数据访问
 */
@protocol MFDictionarySetAccessor <NSObject>
@required
- (void)setObject:(id)value forKey:(id)aKey;

@optional
// 这部分协议不需要实现，由NSObjcet内部私有实现
- (void)setObjectSafe:(id)value forKey:(id)aKey;
- (void)setString:(NSString *)value forKey:(NSString *)aKey;
- (void)setNumber:(NSNumber *)value forKey:(NSString *)aKey;
- (void)setInteger:(NSInteger)value forKey:(NSString *)aKey;
- (void)setInt:(int)value forKey:(NSString *)aKey;
- (void)setFloat:(float)value forKey:(NSString *)aKey;
- (void)setDouble:(double)value forKey:(NSString *)aKey;
- (void)setLongLongValue:(long long)value forKey:(NSString *)aKey;
- (void)setBool:(BOOL)value forKey:(NSString *)aKey;
@end


@protocol MFDictionaryGetAccessor <NSObject>
@required
- (id)objectForKey:(id)aKey;

@optional
// 这部分协议不需要实现，由NSObjcet内部私有实现
- (id)objectForKey:(NSString *)aKey defaultValue:(id)value;
- (NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)value;
- (NSArray *)arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value;
- (NSDictionary *)dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value;
- (NSData *)dataForKey:(NSString *)aKey defaultValue:(NSData *)value;
- (NSDate *)dateForKey:(NSString *)aKey defaultValue:(NSDate *)value;
- (NSNumber *)numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value;
- (NSUInteger)unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value;
- (NSInteger)integerForKey:(NSString *)aKey defaultValue:(NSInteger)value;
- (float)floatForKey:(NSString *)aKey defaultValue:(float)value;
- (double)doubleForKey:(NSString *)aKey defaultValue:(double)value;
- (long long)longLongValueForKey:(NSString *)aKey defaultValue:(long long)value;
- (BOOL)boolForKey:(NSString *)aKey defaultValue:(BOOL)value;
- (int)intForKey:(NSString *)aKey defaultValue:(int)value;

@end
