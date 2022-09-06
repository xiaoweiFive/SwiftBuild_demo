//
//  MDJSONHelper.h
//  MomoChat
//
//  Created by yupengzhang on 15/3/6.
//  Copyright (c) 2015年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MDJSONHelper)

/// 将字典转换为JSON字符串，不带换行
- (NSString *)MDJSONString;
- (NSString *)MDJSON2String DEPRECATED_MSG_ATTRIBUTE("请使用[dict MDJSONString]");
- (NSString *)MDJSON2StringNilOptions DEPRECATED_MSG_ATTRIBUTE("请使用[dict MDJSONString]");
- (NSString *)MDJSONStringNOPrettyPrinted DEPRECATED_MSG_ATTRIBUTE("请使用[dict MDJSONString]");

/// 将字典转换为JSON字符串，带换行
- (NSString *)MDJSONStringWithPrettyPrinted;

/// 将字典转换为JSON Data，不带换行
- (nullable NSData *)MDJSONData;

@end



@interface NSArray (MDJSONHelper)

/// 将数组转换为JSON字符串，不带换行
- (NSString *)MDJSONString;
- (NSString *)MDJSON2String DEPRECATED_MSG_ATTRIBUTE("请使用[array MDJSONString]");
- (NSString *)MDJSON2StringNilOptions DEPRECATED_MSG_ATTRIBUTE("请使用[array MDJSONString]");
- (NSString *)MDJSONStringNOPrettyPrinted DEPRECATED_MSG_ATTRIBUTE("请使用[array MDJSONString]");

/// 将字典转换为JSON字符串，带换行
- (NSString *)MDJSONStringWithPrettyPrinted;

/// 将数组转换为JSON Data，不带换行
- (nullable NSData *)MDJSONData;

@end



@interface NSString (MDJSONHelper)

/// 将JSON字符串转换为字典或数组，默认为可变容器
- (nullable id)objectFromJSONString;
- (nullable id)objectFromMDJSONString DEPRECATED_MSG_ATTRIBUTE("请使用[str objectFromJSONString]");

@end



@interface NSData (MDJSONHelper)

/// 将 Data 转换为字典或数组，默认为可变容器
- (nullable id)objectFromJSONData;

@end

NS_ASSUME_NONNULL_END
