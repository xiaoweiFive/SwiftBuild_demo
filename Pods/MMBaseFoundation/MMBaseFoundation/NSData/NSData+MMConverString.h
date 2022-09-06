//
//  NSData+MMConverString.h
//  MMBaseFoundationDemo
//
//  Created by yzkmac on 2020/3/17.
//  Copyright © 2020 yzkmac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MMConverString)

/// 将NSData的字节流转换为16进制字符串
- (NSString *)mm_hexadecimalString;

@end

NS_ASSUME_NONNULL_END
