//
//  NSObject+MMUtility.h
//  MomoChat
//
//  Created by Zero.D.Saber on 2017/11/4.
//  Copyright © 2017年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MD_FreeBlock)(id unsafeSelf);

@interface NSObject (MMUtility)

/// 对objc做类型判断,属于当前类返回objc,否则返回nil
+ (nullable instancetype)md_cast:(id _Nullable)objc;

/// 当前类实例释放`后`执行这个block
- (void)md_deallocBlock:(MD_FreeBlock)deallocBlock;

@end

NS_ASSUME_NONNULL_END
