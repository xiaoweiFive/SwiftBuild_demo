//
//  MDQuene.m
//  MomoChat
//
//  Created by yzkmac on 2019/12/12.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

#import "MDQuene.h"

@interface MDQuene ()

@property (nonatomic, strong) NSMutableArray *mArr;
@property (nonatomic, assign) NSInteger maxCount;

@end

@implementation MDQuene

- (instancetype)init {
    return [self initWithMaxCount:0];
}

- (instancetype)initWithMaxCount:(NSInteger)maxCount
{
    self = [super init];
    if (self) {
        self.maxCount = maxCount;
        self.mArr = [NSMutableArray array];
    }
    return self;
}

- (BOOL)append:(nonnull id)object//声明与实现不一致缺少nonnull
{
    if (!object || [self isFull]) {
        return NO;
    }
    [self.mArr addObject:object];
    return YES;
}

- (BOOL)insert:(nonnull id)object
{
    if (!object || [self isFull]) {
        return NO;
    }
    [self.mArr insertObject:object atIndex:0];
    return YES;
}


- (BOOL)upsertToTail:(nonnull id)object
{
    if (!object) {
        return NO;
    }
    BOOL contain = [self containsObject:object];
    if (contain) {
        [self.mArr removeObject:object];
        [self.mArr addObject:object];
        return YES;
    }
    else {
        return [self append:object];
    }
}

- (BOOL)upsertToHead:(nonnull id)object
{
    if (!object) {
        return NO;
    }
    BOOL contain = [self containsObject:object];
    if (contain) {
        [self.mArr removeObject:object];
        [self.mArr insertObject:object atIndex:0];
        return YES;
    }
    else {
        return [self insert:object];
    }
}


- (id)remove
{
    id obj = [self.mArr firstObject];
    if (obj) {
        [self.mArr removeObjectAtIndex:0];
    }
    return obj;
}

- (void)removeAll
{
    [self.mArr removeAllObjects];
}

- (BOOL)containsObject:(id)obj
{
    if (!obj) {
        return NO;
    }
    return [self.mArr containsObject:obj];
}


- (BOOL)isFull
{
    if (self.maxCount == 0) {
        return NO;
    }
    return self.mArr.count >= self.maxCount;
}

- (BOOL)isEmpty
{
    return self.mArr.count == 0;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>\n%@", NSStringFromClass([self class]), self, self.mArr];
}

@end
