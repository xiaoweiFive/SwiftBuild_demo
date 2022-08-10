//
//  MDThreadSafeDictionary.m
//  MomoChat
//
//  Created by xu bing on 16/3/8.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//

#import "MDThreadSafeDictionary.h"
#import "MDLockDefinitions.h"

#define ThreadSafeHandle(...) Mutex_Lock(); \
__VA_ARGS__; \
Mutex_UnLock();

@implementation MDThreadSafeDictionary
{
    NSMutableDictionary *_dic;
    pthread_mutex_t _lock;
}

- (void)dealloc {
    Mutex_LockDestroy();
}

- (instancetype)init
{
    self = [super init];
    if (self) {
     Mutex_LockInit();
     _dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)adictionary
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
        _dic = [[NSMutableDictionary alloc] initWithDictionary:adictionary];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
        _dic = [[NSMutableDictionary alloc] initWithCapacity:numItems];
    }
    return self;
}

#pragma mark -- handle

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    ThreadSafeHandle([_dic setObject:anObject forKey:aKey]);
}

- (id)objectForKey:(id)aKey
{
    ThreadSafeHandle(id  obj = [_dic objectForKey:aKey]);
    return obj;
}

- (NSArray *)allKeys
{
    ThreadSafeHandle(NSArray * array = [_dic allKeys]);
    return array;
}

- (NSArray *)allValues
{
    ThreadSafeHandle(NSArray * array = [_dic allValues]);
    return array;
}

- (NSEnumerator *)keyEnumerator
{
    ThreadSafeHandle(NSEnumerator * enumerator = [_dic keyEnumerator]);
    return enumerator;
}

- (NSEnumerator *)objectEnumerator
{
    ThreadSafeHandle(NSEnumerator * enumerator = [_dic objectEnumerator]);
    return enumerator;
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE^)(id key, id obj, BOOL *stop))block
{
    ThreadSafeHandle([_dic enumerateKeysAndObjectsUsingBlock:block]);
}

- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE^)(id key, id obj, BOOL *stop))block
{
    ThreadSafeHandle([_dic enumerateKeysAndObjectsWithOptions:opts usingBlock:block]);
}

- (void)removeObjectForKey:(id)aKey
{
    ThreadSafeHandle([_dic removeObjectForKey:aKey]);
}

- (void)removeAllObjects
{
    ThreadSafeHandle([_dic removeAllObjects]);
}

- (void)removeObjectsForKeys:(NSArray *)keyArray
{
    ThreadSafeHandle([_dic removeObjectsForKeys:keyArray]);
}

- (NSUInteger)count
{
    ThreadSafeHandle(NSUInteger count = _dic.count);
    return count;
}

// copy

- (id)copyWithZone:(NSZone *)zone
{
    return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    ThreadSafeHandle(id adictionary = [[self.class allocWithZone:zone] initWithDictionary:_dic]);
    return adictionary;
}

- (NSUInteger)hash {
    ThreadSafeHandle(NSUInteger hash = [_dic hash]);
    return hash;
}

// NSCoding
- (Class)classForCoder
{
    return [self class];
}

@end
