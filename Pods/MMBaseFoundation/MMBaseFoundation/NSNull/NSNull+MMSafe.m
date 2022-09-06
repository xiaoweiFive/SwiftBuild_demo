//
//  NSNull+MMSafe.m
//  MMBaseFoundation
//
//  Created by song.meng on 2021/5/24.
//

#import "NSNull+MMSafe.h"

@implementation NSNull (MMSafe)

#pragma mark - Forward Message

// 其他未识别方法进入消息转发，把消息转发给 nil
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [NSObject instanceMethodSignatureForSelector:@selector(init)];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    anInvocation.target = nil;
    [anInvocation invoke];
}

@end
