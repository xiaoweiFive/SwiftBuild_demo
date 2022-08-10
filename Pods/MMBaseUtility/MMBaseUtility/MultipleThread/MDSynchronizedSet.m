//
//  MDSynchronizedSet.m
//  MomoChat
//
//  Created by wang.xu_1106 on 16/8/4.
//  Copyright © 2016年 wemomo.com. All rights reserved.
//

#import "MDSynchronizedSet.h"

#define ThreadSafeHandle(...) [self lock]; \
__VA_ARGS__ \
[self unlock];

@implementation MDSynchronizedSet
{
    NSRecursiveLock *_lock;
    NSMutableSet *_set;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = [[NSRecursiveLock alloc] init];
        _set = [[NSMutableSet alloc] init];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        _lock = [[NSRecursiveLock alloc] init];
        _set = [[NSMutableSet alloc] initWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithObjects:(const __unsafe_unretained id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        _lock = [[NSRecursiveLock alloc] init];
        _set = [[NSMutableSet alloc] initWithObjects:objects count:cnt];
    }
    return self;
}

- (void)dealloc
{
    ThreadSafeHandle(_set = nil;)
}

- (NSSet *)copy
{
    ThreadSafeHandle(NSSet *set = [_set copy];)
    return set;
}

- (NSMutableSet *)mutableCopy
{
    ThreadSafeHandle(NSMutableSet *set = [_set mutableCopy];)
    return set;
}

#pragma mark - NSSet
- (NSUInteger)count
{
    ThreadSafeHandle(NSUInteger count = [_set count];)
    return count;
}

- (id)member:(id)object
{
    ThreadSafeHandle(id member = [_set member:object];)
    return member;
}

- (NSEnumerator *)objectEnumerator
{
    ThreadSafeHandle(NSEnumerator *enumerator = [_set objectEnumerator];)
    return enumerator;
}

#pragma mark - NSExtendedSet
- (NSArray *)allObjects
{
    ThreadSafeHandle(NSArray *objects = [_set allObjects];)
    return objects;
}

- (id)anyObject
{
    ThreadSafeHandle(id object = [_set anyObject];)
    return object;
}

- (BOOL)containsObject:(id)anObject
{
    ThreadSafeHandle(BOOL isContains = [_set containsObject:anObject];)
    return isContains;
}

- (NSString *)description
{
    ThreadSafeHandle(NSString *description = [_set description];)
    return description;
}

- (NSString *)descriptionWithLocale:(id)locale
{
    ThreadSafeHandle(NSString *description = [_set descriptionWithLocale:locale];)
    return description;
}

- (BOOL)intersectsSet:(NSSet *)otherSet
{
    ThreadSafeHandle(BOOL isIntersects = [_set intersectsSet:otherSet];)
    return isIntersects;
}

- (BOOL)isEqualToSet:(NSSet *)otherSet
{
    ThreadSafeHandle(BOOL isEqual = [_set isEqualToSet:otherSet];)
    return isEqual;
}

- (BOOL)isSubsetOfSet:(NSSet *)otherSet
{
    ThreadSafeHandle(BOOL isSubset = [_set isSubsetOfSet:otherSet];)
    return isSubset;
}

- (void)makeObjectsPerformSelector:(SEL)aSelector
{
    ThreadSafeHandle([_set makeObjectsPerformSelector:aSelector];)
}

- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument
{
    ThreadSafeHandle([_set makeObjectsPerformSelector:aSelector withObject:argument];)
}

- (NSSet *)setByAddingObject:(id)anObject
{
    ThreadSafeHandle(NSSet *set = [_set setByAddingObject:anObject];)
    return set;
}

- (NSSet *)setByAddingObjectsFromSet:(NSSet *)other
{
    ThreadSafeHandle(NSSet *set = [_set setByAddingObjectsFromSet:other];)
    return set;
}

- (NSSet *)setByAddingObjectsFromArray:(NSArray *)other
{
    ThreadSafeHandle(NSSet *set = [_set setByAddingObjectsFromArray:other];)
    return set;
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE^)(id obj, BOOL *stop))block
{
    ThreadSafeHandle([_set enumerateObjectsWithOptions:opts usingBlock:block];)
}

- (NSSet *)objectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, BOOL *stop))predicate
{
    ThreadSafeHandle(NSSet *objects = [_set objectsWithOptions:opts passingTest:predicate];)
    return objects;
}

#pragma mark - NSKeyValueCoding
- (id)valueForKey:(NSString *)key
{
    ThreadSafeHandle(id value = [_set valueForKey:key];)
    return value;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    ThreadSafeHandle([_set setValue:value forKey:key];)
}

#pragma mark - NSPredicateSupport
- (NSSet *)filteredSetUsingPredicate:(NSPredicate *)predicate
{
    ThreadSafeHandle(NSSet *filteredSet = [_set filteredSetUsingPredicate:predicate];)
    return filteredSet;
}

#pragma mark - NSSortDescriptorSorting
- (NSArray *)sortedArrayUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
{
    ThreadSafeHandle(NSArray *sortedArray = [_set sortedArrayUsingDescriptors:sortDescriptors];)
    return sortedArray;
}

#pragma mark - NSMutableSet
- (void)addObject:(id)object
{
    ThreadSafeHandle([_set addObject:object];)
}

- (void)removeObject:(id)object
{
    ThreadSafeHandle([_set removeObject:object];)
}

#pragma mark - NSExtendedMutableSet
- (void)addObjectsFromArray:(NSArray *)array
{
    ThreadSafeHandle([_set addObjectsFromArray:array];)
}

- (void)intersectSet:(NSSet *)otherSet
{
    ThreadSafeHandle([_set intersectSet:otherSet];)
}

- (void)minusSet:(NSSet *)otherSet
{
    ThreadSafeHandle([_set minusSet:otherSet];)
}

- (void)removeAllObjects
{
    ThreadSafeHandle([_set removeAllObjects];)
}

- (void)unionSet:(NSSet *)otherSet
{
    ThreadSafeHandle([_set unionSet:otherSet];)
}

- (void)setSet:(NSSet *)otherSet
{
    ThreadSafeHandle([_set setSet:otherSet];)
}

#pragma mark - NSPredicateSupport
- (void)filterUsingPredicate:(NSPredicate *)predicate
{
    ThreadSafeHandle([_set filterUsingPredicate:predicate];)
}

#pragma mark - NSLocking
- (void)lock
{
    [_lock lock];
}

- (void)unlock
{
    [_lock unlock];
}

@end
