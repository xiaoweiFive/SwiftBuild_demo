//
//  NSArray+Safe.h
//  MomoChat
//
//  Created by 杨 红林 on 13-7-4.
//  Copyright (c) 2013年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (MMSafe)

- (ObjectType)objectAtIndex:(NSUInteger)index kindOfClass:(Class)aClass;
- (ObjectType)objectAtIndex:(NSUInteger)index memberOfClass:(Class)aClass;

// 推荐使用下面的类方法，不要使用实例方法
- (ObjectType)objectAtIndex:(NSUInteger)index defaultValue:(ObjectType)value;
- (NSString *)stringAtIndex:(NSUInteger)index defaultValue:(NSString *)value;
- (NSNumber *)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)value;
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)value;
- (NSArray *)arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)value;
- (NSData *)dataAtIndex:(NSUInteger)index defaultValue:(NSData *)value;
- (NSDate *)dateAtIndex:(NSUInteger)index defaultValue:(NSDate *)value;
- (float)floatAtIndex:(NSUInteger)index defaultValue:(float)value;
- (double)doubleAtIndex:(NSUInteger)index defaultValue:(double)value;
- (NSInteger)integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)value;
- (NSUInteger)unintegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)value;
- (BOOL)boolAtIndex:(NSUInteger)index defaultValue:(BOOL)value;

+ (ObjectType)array:(NSArray *)array objectAtIndex:(NSUInteger)index defaultValue:(ObjectType)value;
+ (NSString *)array:(NSArray *)array stringAtIndex:(NSUInteger)index defaultValue:(NSString *)value;
+ (NSNumber *)array:(NSArray *)array numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)value;
+ (NSDictionary *)array:(NSArray *)array dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)value;
+ (NSArray *)array:(NSArray *)array arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)value;
+ (NSData *)array:(NSArray *)array dataAtIndex:(NSUInteger)index defaultValue:(NSData *)value;
+ (NSDate *)array:(NSArray *)array dateAtIndex:(NSUInteger)index defaultValue:(NSDate *)value;
+ (float)array:(NSArray *)array floatAtIndex:(NSUInteger)index defaultValue:(float)value;
+ (double)array:(NSArray *)array doubleAtIndex:(NSUInteger)index defaultValue:(double)value;
+ (NSInteger)array:(NSArray *)array integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)value;
+ (NSUInteger)array:(NSArray *)array unintegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)value;
+ (BOOL)array:(NSArray *)array boolAtIndex:(NSUInteger)index defaultValue:(BOOL)value;

@end

@interface NSMutableArray<ObjectType> (Safe)

- (void)removeObjectAtIndexInBoundary:(NSUInteger)index;
- (void)insertObject:(ObjectType)anObject atIndexInBoundary:(NSUInteger)index;
- (void)replaceObjectAtInBoundaryIndex:(NSUInteger)index withObject:(ObjectType)anObject;

// 排除nil 和 NSNull
- (void)addObjectSafe:(ObjectType)anObject;

@end
