//
//  NSMutableSet+Safe.m
//  MMFoundation
//
//  Created by wang.xu_1106 on 16/12/5.
//  Copyright © 2016年 momo783. All rights reserved.
//

#import "NSMutableSet+MMSafe.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSMutableSet (MMSafe)

#pragma mark - safe hook -

+ (void)load {
#ifdef DISTRIBUTION
    [objc_getClass("__NSSetM") swizzleInstanceSelector:@selector(addObject:) withNewSelector:@selector(md_safeAddObject:)];
    [objc_getClass("__NSSetM") swizzleInstanceSelector:@selector(removeObject:) withNewSelector:@selector(md_safeRemoveObject:)];
#endif
}

- (void)md_safeAddObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self md_safeAddObject:anObject];
}

- (void)md_safeRemoveObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self md_safeRemoveObject:anObject];
}

#pragma mark - other -

// 排除nil
- (void)addObjectSafe:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

- (void)removeObjectSafe:(id)object
{
    if (object) {
        [self removeObject:object];
    }
}

@end
