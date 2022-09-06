//
//  NSDate+Format.h
//  xiwu
//
//  Created by yzk on 14-7-21.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, MMDateFormatType) {
    MMDateFormatTypeAll,               // 2014-03-04 13:23:35:67
    MMDateFormatTypeAllOther,          // 2014-03-04 13:23:35.67
    MMDateFormatTypeDateAndTime,       // 2014-03-04 13:23:35
    MMDateFormatTypeDateAndMinite,     // 2014-03-04 13:23

    MMDateFormatTypeTime,              // 13:23:35
    MMDateFormatTypePreciseTime,       // 13:23:35:67

    MMDateFormatTypeYearMonthDay,      // 2014-03-04
    MMDateFormatTypeYearMonthDayOther, // 2014年03月04日
    MMDateFormatTypeYearMonth,         // 2014-03
    MMDateFormatTypeMonthDay,          // 03-04
};

@interface NSDate (MMFormat)

/**
 *  NSDate 转 NSString
 *
 *  @param format 日期格式类型
 *
 *  @return 日期字符串
 */
- (NSString *)md_stringWithDateFormat:(MMDateFormatType)format;
- (NSString *)md_stringWithDateFormatString:(NSString *)dateFormatString;

@end

@interface NSString (MMFormat)

/**
 *  NSString 转 NSDate
 *
 *  @param format 日期格式类型
 *
 *  @return NSDate日期
 */
- (NSDate *)md_dateWithDateFormat:(MMDateFormatType)format;
- (NSDate *)md_dateWithDateFormatString:(NSString *)dateFormatString;

/**
 *  将某种格式的日期字符串 转 另一种格式的日期字符串
 *
 *  @param toFormat   目标日期格式类型
 *  @param fromFormat 源日期格式类型
 *
 *  @return 转换后的日期字符串
 */
- (NSString *)md_stringConverToDateFormat:(MMDateFormatType)toFormat
                           fromDateFormat:(MMDateFormatType)fromFormat;
- (NSString *)md_stringConverToDateFormatString:(NSString *)toFormatString
                           fromDateFormatString:(NSString *)fromFormatString;

@end
