//
//  MMSDateValue.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

public protocol MMSDateValueCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}

/// 日期自动转换
///
/// 对于接口返回的的日期如: { "date": "1996-12-19T16:39:57-08:00" }
/// 可以自动映射为 Date
///
/// 使用方式：@MMSDateValue<MMSISO8601Strategy> var date: Date
/// 对于更多的日期格式: 你可以实现协议: MMSDateValueCodableStrategy 即可, 在模型构造的时候，传入自定义的 @MMSDateValue<MMSDateValueCodableStrategy 协议> 即可
///
/// 这样就不用每次自己手动转换时间了. 默认提供三种
/// 1、  MMSISO8601Strategy
/// 2、  MMSTimeIntervalToDate
/// 3、  MMSTimestampToDate
///
@propertyWrapper
public struct MMSDateValue<Formatter: MMSDateValueCodableStrategy>: Codable {
    private let value: Formatter.RawValue
    public var wrappedValue: Date

    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        self.value = Formatter.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.value = try Formatter.RawValue(from: decoder)
        self.wrappedValue = try Formatter.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

/// 接受转换字符串为: 1996-12-19T16:39:57-08:00 的日期
public struct MMSISO8601Strategy: MMSDateValueCodableStrategy {
    public static func decode(_ value: String) throws -> Date {
        guard let date = ISO8601DateFormatter().date(from: value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "无效的日期格式"))
        }
        return date
    }
    
    public static func encode(_ date: Date) -> String {
        return ISO8601DateFormatter().string(from: date)
    }
}

/// 接受转换字符串为 timeIntervalSince1970 的日期
public struct MMSTimeIntervalToDate: MMSDateValueCodableStrategy {
    public static func decode(_ value: String) throws -> Date {
        guard let timeInterval = TimeInterval(value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "无效的日期格式"))
        }
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    public static func encode(_ date: Date) -> String {
        return date.timeIntervalSince1970.description
    }
}


/// 接受 TimeInterval (Double) 类型的数据转换为 Date
public struct MMSTimestampToDate: MMSDateValueCodableStrategy {
    public static func decode(_ value: TimeInterval) throws -> Date {
        return Date(timeIntervalSince1970: value)
    }
    
    public static func encode(_ date: Date) -> TimeInterval {
        return date.timeIntervalSince1970
    }
}

