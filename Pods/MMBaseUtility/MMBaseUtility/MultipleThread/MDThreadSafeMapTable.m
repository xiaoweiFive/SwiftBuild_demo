//
//  MDThreadSafeMapTable.m
//  MomoChat
//
//  Created by Dai Dongpeng on 2018/8/21.
//  Copyright © 2018年 wemomo.com. All rights reserved.
//

#import "MDThreadSafeMapTable.h"
#import <pthread.h>
#import "MDLockDefinitions.h"

#define ThreadSafeHandle(...) Mutex_Lock(); \
__VA_ARGS__; \
Mutex_UnLock();

@interface MDThreadSafeMapTable ()
{
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMapTable *mapTable;

@end

@implementation MDThreadSafeMapTable

+ (MDThreadSafeMapTable *)mapTableWithKeyOptions:(NSPointerFunctionsOptions)keyOptions valueOptions:(NSPointerFunctionsOptions)valueOptions
{
    MDThreadSafeMapTable *mt = [[MDThreadSafeMapTable alloc] init];
    mt.mapTable = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];
    return mt;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        Mutex_LockInit();
    }
    return self;
}

- (void)dealloc
{
    ThreadSafeHandle(_mapTable = nil);
    Mutex_LockDestroy();
}

- (NSUInteger)count
{
    ThreadSafeHandle(NSUInteger c = self.mapTable.count);
    return c;
}

- (id)objectForKey:(id)aKey
{
    if (!aKey) {
        return nil;
    }
    ThreadSafeHandle(id obj = [self.mapTable objectForKey:aKey]);
    return obj;
}

- (void)removeObjectForKey:(id)aKey
{
    if (!aKey) {
        return;
    }
    ThreadSafeHandle([self.mapTable removeObjectForKey:aKey]);
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (!aKey) {
        return;
    }
    if (anObject) {
        ThreadSafeHandle([self.mapTable setObject:anObject forKey:aKey]);
    } else {
        ThreadSafeHandle([self.mapTable removeObjectForKey:aKey]);
    }
}

- (void)removeAllObjects
{
    ThreadSafeHandle([self.mapTable removeAllObjects]);
}

@end
