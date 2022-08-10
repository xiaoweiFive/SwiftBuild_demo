//
//  MDWeakProxy.m
//  MomoChat
//
//  Created by yupengzhang on 14-12-11.
//  Copyright (c) 2014年 wemomo.com. All rights reserved.
//

#import "MDWeakProxy.h"

@interface MDWeakProxy()
@property (nonatomic, strong)id mdStrongTarget;
@end

@implementation MDWeakProxy
+ (instancetype)weakProxyForObject:(id)targetObject
{
    MDWeakProxy *weakProxy = [MDWeakProxy alloc];
    weakProxy.mdTargetObj = targetObject;
    return weakProxy;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)assignWeakToStrong
{
    self.mdStrongTarget = self.mdTargetObj;
    return self.mdStrongTarget;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mdTargetObj respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    if ([self respondsToSelector:selector]) {
        return self.mdTargetObj;
    }else{
        return nil;
    }
}

- (NSUInteger)hash {
    return [_mdTargetObj hash];
}

- (BOOL)isEqual:(MDWeakProxy *)proxy {
    if (_mdTargetObj == proxy) return YES;
    if (![proxy isMemberOfClass:MDWeakProxy.class]) return NO;
    
    return [_mdTargetObj isEqual:proxy.mdTargetObj];
}
@end
