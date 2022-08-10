//
//  MDThreadSafeSet.m
//  MomoChat
//
//  Created by wang.xu_1106 on 16/8/5.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//

#import "MDThreadSafeSet.h"
#import "MDLockDefinitions.h"

#define ThreadSafeHandle(...) Mutex_Lock(); \
__VA_ARGS__; \
Mutex_UnLock();

@implementation MDThreadSafeSet
{
    NSMutableSet *_set;
    pthread_mutex_t _lock;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
        _set = [[NSMutableSet alloc] init];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
        _set = [[NSMutableSet alloc] initWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithObjects:(const __unsafe_unretained id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
        _set = [[NSMutableSet alloc] initWithObjects:objects count:cnt];
    }
    return self;
}

- (void)dealloc
{
    ThreadSafeHandle(_set = nil;)
    Mutex_LockDestroy();
}

- (NSUInteger)count
{
    ThreadSafeHandle(NSUInteger count = [_set count];)
    return count;
}

- (id)member:(id)object
{
    ThreadSafeHandle(id obj = [_set member:object];)
    return obj;
}

- (NSEnumerator *)objectEnumerator
{
    ThreadSafeHandle(NSEnumerator *enumerator = [_set objectEnumerator];)
    return enumerator;
}

- (void)addObject:(id)object
{
    ThreadSafeHandle([_set addObject:object];)
}

- (void)removeObject:(id)object
{
    ThreadSafeHandle([_set removeObject:object];)
}

@end
