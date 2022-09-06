//
//  NSDate+Format.m
//  xiwu
//
//  Created by yzk on 14-7-21.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "NSDate+MMFormat.h"

NSString * getFormatString(MMDateFormatType formatType);

@implementation NSDate (MMFormat)

- (NSDateFormatter *)md_dateFormatter {
    static dispatch_once_t onceToken;
    static NSDateFormatter *_dateFormatter2 = nil;
    dispatch_once(&onceToken, ^{
        _dateFormatter2 = [[NSDateFormatter alloc] init];
        _dateFormatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    });
    return _dateFormatter2;
}

#pragma mark - public

- (NSString *)md_stringWithDateFormat:(MMDateFormatType)format
{
    return [self md_stringWithDateFormatString:getFormatString(format)];
}

- (NSString *)md_stringWithDateFormatString:(NSString *)dateFormatString
{
    [self.md_dateFormatter setDateFormat:dateFormatString];
    NSString *date_time = [NSString stringWithString:[self.md_dateFormatter stringFromDate:self]];
    return date_time;
}

@end

@implementation NSString (MMFormat)

- (NSDateFormatter *)md_dateFormatter {
    static dispatch_once_t onceToken;
    static NSDateFormatter *_dateFormatter2 = nil;
    dispatch_once(&onceToken, ^{
        _dateFormatter2 = [[NSDateFormatter alloc] init];
        _dateFormatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    });
    return _dateFormatter2;
}

#pragma mark - public

- (NSDate *)md_dateWithDateFormat:(MMDateFormatType)format
{
    return [self md_dateWithDateFormatString:getFormatString(format)];
}

- (NSDate *)md_dateWithDateFormatString:(NSString *)dateFormatString
{
    [self.md_dateFormatter setDateFormat:dateFormatString];
    NSDate *date = [self.md_dateFormatter dateFromString:self];
    return date;
}

- (NSString *)md_stringConverToDateFormat:(MMDateFormatType)toFormat
                        fromDateFormat:(MMDateFormatType)fromFormat
{
    return [self md_stringConverToDateFormatString:getFormatString(toFormat)
                              fromDateFormatString:getFormatString(fromFormat)];
}

- (NSString *)md_stringConverToDateFormatString:(NSString *)toFormatString
                           fromDateFormatString:(NSString *)fromFormatString
{
    NSDate *date = [self md_dateWithDateFormatString:fromFormatString];
    return [date md_stringWithDateFormatString:toFormatString];
}

@end

NSString *getFormatString(MMDateFormatType formatType) {
    NSString *formatString;
    switch (formatType) {
        case MMDateFormatTypeAll:
            formatString = @"yyyy-MM-dd HH:mm:ss:SS";
            break;
        case MMDateFormatTypeAllOther:
            formatString = @"yyyy-MM-dd HH:mm:ss.SS";
            break;
        case MMDateFormatTypeDateAndTime:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        case MMDateFormatTypeDateAndMinite:
            formatString = @"yyyy-MM-dd HH:mm";
            break;
        case MMDateFormatTypeTime:
            formatString = @"HH:mm:ss";
            break;
        case MMDateFormatTypePreciseTime:
            formatString = @"HH:mm:ss:SS";
            break;
        case MMDateFormatTypeYearMonthDay:
            formatString = @"yyyy-MM-dd";
            break;
        case MMDateFormatTypeYearMonthDayOther:
            formatString = @"yyyy年MM月dd日";
            break;
        case MMDateFormatTypeYearMonth:
            formatString = @"yyyy-MM";
            break;
        case MMDateFormatTypeMonthDay:
            formatString = @"MM-dd";
            break;
    }
    return formatString;
}
