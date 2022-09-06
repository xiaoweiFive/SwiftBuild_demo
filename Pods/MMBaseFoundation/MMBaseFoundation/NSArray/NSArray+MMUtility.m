//
//  NSArray+MMUtility.m
//  MomoChat
//
//  Created by Zero.D.Saber on 2018/5/8.
//  Copyright © 2018年 wemomo.com. All rights reserved.
//

#import "NSArray+MMUtility.h"

@implementation NSArray (MMUtility)

- (NSMutableArray *)md_map:(id (^)(id, NSUInteger))block {
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = block ? block(obj, idx) : nil;
        if (value) {
            [mutArr addObject:value];
        }
    }];
    return mutArr;
}

- (NSMutableArray *)md_filter:(BOOL (^)(id objc, NSUInteger idx))block {
    if (!block) return self.md_mutableArray;
    
    NSMutableArray *filteredMutArr = @[].mutableCopy;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isPass = block(obj, idx);
        isPass ? [filteredMutArr addObject:obj] : NULL;
    }];
    return filteredMutArr;
}

- (NSMutableArray *)md_flatten {
    NSMutableArray *flattenedMutArray = @[].mutableCopy;
    for (id value in self) {
        if ([value isKindOfClass:[NSArray class]]) {
            [flattenedMutArray addObjectsFromArray:[(NSArray *)value md_flatten]];
        }
        else {
            [flattenedMutArray addObject:value];
        }
    }
    return flattenedMutArray;
}

- (id)md_reduce:(id(^)(id lastResult, id currentValue, NSUInteger idx))block {
    __block id result = nil;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        result = block(result, obj, idx);
    }];
    return result;
}

- (NSMutableArray<NSMutableArray *> *)md_zip:(NSArray *)otherArray {
    NSMutableArray *resultArr = @[].mutableCopy;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id otherValue = (idx < otherArray.count) ? otherArray[idx] : nil;
        if (otherValue) {
            NSMutableArray *tempArr = @[].mutableCopy;
            [tempArr addObject:obj];
            [tempArr addObject:otherValue];
            
            [resultArr addObject:tempArr];
        } else {
            *stop = YES;
        }
    }];
    return resultArr;
}

- (void)md_forEach:(void(^)(id objc, NSUInteger idx))block {
    if (!block) return;
    
    NSUInteger index = 0;
    for (id obj in self) {
        block(obj, index++);
    }
}

- (NSMutableArray *)md_mutableArray {
    if ([self isKindOfClass:[NSMutableArray class]]) {
        return (NSMutableArray *)self;
    }
    else {
        return [NSMutableArray arrayWithArray:self];
    }
}

- (NSMutableArray *)md_removeOneObject:(BOOL(^)(id object, NSInteger index))conditionBlock {
    NSMutableArray *mutArr = self.md_mutableArray;
    if (!conditionBlock) return mutArr;
    
    [mutArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL finded = conditionBlock(obj, idx);
        if (finded) {
            [mutArr removeObject:obj];
        }
        *stop = finded;
    }];
    return mutArr;
}

@end
