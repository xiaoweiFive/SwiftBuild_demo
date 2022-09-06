//
//  NSObject+MMUtility.m
//  MomoChat
//
//  Created by Zero.D.Saber on 2017/11/4.
//  Copyright © 2017年 wemomo.com. All rights reserved.
//

#import "NSObject+MMUtility.h"
#import <objc/runtime.h>

@interface MMZDWeakSelf : NSObject

@property (nonatomic, copy, readonly) MD_FreeBlock deallocBlock;
@property (nonatomic, unsafe_unretained, readonly) id realTarget;

- (instancetype)initWithBlock:(MD_FreeBlock)deallocBlock realTarget:(id)realTarget;

@end

@implementation MMZDWeakSelf

- (instancetype)initWithBlock:(MD_FreeBlock)deallocBlock realTarget:(id)realTarget {
    self = [super init];
    if (self) {
        //属性设为readonly,并用指针指向方式,是参照RACDynamicSignal中的写法
        self->_deallocBlock = [deallocBlock copy];
        self->_realTarget = realTarget;
    }
    return self;
}

- (void)dealloc {
    if (nil != self.deallocBlock) {
        self.deallocBlock(self.realTarget);
#if DEBUG
        NSLog(@"成功移除对象");
#endif
    }
}

@end

@implementation NSObject (MMUtility)

#pragma mark - Cast

+ (instancetype)md_cast:(id)objc {
    if (!objc) return nil;
    
    if ([objc isKindOfClass:self.class]) {
        return objc;
    }
    return nil;
}

#pragma mark - Dealloc

- (void)md_deallocBlock:(MD_FreeBlock)deallocBlock {
    if (!deallocBlock) return;
    
    @autoreleasepool {
        NSMutableArray *blocks = objc_getAssociatedObject(self, _cmd);
        if (!blocks) {
            blocks = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, _cmd, blocks, OBJC_ASSOCIATION_RETAIN);
        }
        MMZDWeakSelf *blockExecutor = [[MMZDWeakSelf alloc] initWithBlock:deallocBlock realTarget:self];
        /// 原理: 当self释放时,它所绑定的属性也自动会释放
        [blocks addObject:blockExecutor];
    }
}

@end
