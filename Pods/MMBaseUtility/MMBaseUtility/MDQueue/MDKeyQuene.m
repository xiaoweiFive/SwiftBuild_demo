//
//  MDKeyQuene.m
//  MomoChat
//
//  Created by yzkmac on 2019/12/12.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import "MDKeyQuene.h"
#import "MDQuene.h"

@interface MDKeyQuene ()
@property (nonatomic, strong) MDQuene *queue;
@property (nonatomic, strong) NSMutableDictionary *mDict;
@end

@implementation MDKeyQuene

- (instancetype)init {
    return [self initWithMaxCount:0];
}

- (instancetype)initWithMaxCount:(NSInteger)maxCount
{
    self = [super init];
    if (self) {
        self.queue = [[MDQuene alloc] initWithMaxCount:maxCount];
        self.mDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)append:(nonnull id)obj key:(nonnull NSString *)key//声明与实现不一致缺少nonnull
{
    if (!key || !obj || [self objectForKey:key]) {
        return NO;
    }
    BOOL success = [self.queue append:@{key:obj}];
    if (success) {
        [self.mDict setValue:obj forKey:key];
    }
    return success;
}

- (BOOL)insert:(nonnull id)obj key:(nonnull NSString *)key
{
    if (!key || !obj || [self objectForKey:key]) {
        return NO;
    }
    BOOL success = [self.queue insert:@{key:obj}];
    if (success) {
        [self.mDict setValue:obj forKey:key];
    }
    return success;
}

- (BOOL)upsertToTail:(nonnull id)object key:(nonnull NSString *)key
{
    if (!object) {
        return NO;
    }
    BOOL success = [self.queue upsertToTail:@{key:object}];
    if (success) {
        [self.mDict setValue:object forKey:key];
    }
    return success;
}

- (BOOL)upsertToHead:(nonnull id)object key:(nonnull NSString *)key
{
    if (!object) {
        return NO;
    }
    BOOL success = [self.queue upsertToHead:@{key:object}];
    if (success) {
        [self.mDict setValue:object forKey:key];
    }
    return success;
}


- (id)remove
{
    NSDictionary *obj = [self.queue remove];
    NSString *key = obj.allKeys.firstObject;
    NSString *value = obj.allValues.firstObject;
    if (key) {
        [self.mDict removeObjectForKey:key];
    }
    return value;
}

- (void)removeAll
{
    [self.queue removeAll];
    [self.mDict removeAllObjects];
}

- (BOOL)containsObject:(id)obj
{
    if (!obj) {
        return NO;
    }
    return [self.mDict.allValues containsObject:obj];
}

/// 根据key取出对应的obj
/// @param key 元素的key
- (id)objectForKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    return [self.mDict objectForKey:key];
}


- (BOOL)isFull
{
    return self.queue.isFull;
}

- (BOOL)isEmpty
{
    return self.queue.isEmpty;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>\n%@", NSStringFromClass([self class]), self, self.queue];
}

@end
