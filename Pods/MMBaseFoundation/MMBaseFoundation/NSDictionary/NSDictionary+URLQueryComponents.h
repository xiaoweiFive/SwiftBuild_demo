//
//  NSDictionary+URLQueryComponents.h
//  MomoChat
//
//  Created by lijiahan on 13-6-19.
//  Copyright (c) 2013年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLQueryComponents)

/// 将字典转为 key1=value1&key2=value2&key3=value3 形式，只能转 字符串和数字。
- (NSString *)stringFromQueryComponents;

@end
