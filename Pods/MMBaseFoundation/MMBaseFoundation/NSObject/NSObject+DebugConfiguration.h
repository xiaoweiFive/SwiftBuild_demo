//
//  NSObject+DebugConfiguration.h
//  MMBaseFoundation
//
//  Created by Allen on 2020/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DebugConfiguration)

//当类型不匹配的时候是否抛异常
+ (void)setThrowExceptionEnabled:(BOOL)enabled;

//当类型不匹配但又是string、number等可以相互转化的类型时
+ (void)setIllegalTypeLogEnabled:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
