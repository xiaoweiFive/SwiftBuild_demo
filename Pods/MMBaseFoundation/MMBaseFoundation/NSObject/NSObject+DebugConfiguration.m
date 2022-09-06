//
//  NSObject+DebugConfiguration.m
//  MMBaseFoundation
//
//  Created by Allen on 2020/9/23.
//

#import "NSObject+DebugConfiguration.h"
#import "NSObject+MFDictionaryAdapterPrivate.h"

@implementation NSObject (DebugConfiguration)

//当类型不匹配的时候是否抛异常
+ (void)setThrowExceptionEnabled:(BOOL)enabled
{
#if DEBUG
    throwExceptionEnabled = enabled;
#endif
}

//当类型不匹配但又是string、number等可以相互转化的类型时
+ (void)setIllegalTypeLogEnabled:(BOOL)enabled
{
#if DEBUG
    illegalTypeLogEnabled = enabled;
#endif
}

@end
