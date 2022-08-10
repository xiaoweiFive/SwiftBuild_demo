//
//  MMSTypeWrap.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/3/4.
//

import UIKit
prefix operator *

public protocol MMSWrapTypeProtocol {}
extension String: MMSWrapTypeProtocol {}
extension CGFloat: MMSWrapTypeProtocol {}
extension Double: MMSWrapTypeProtocol {}
extension Int: MMSWrapTypeProtocol {}
extension Bool: MMSWrapTypeProtocol {}

/// 类型包裹器
/// 解决重写`Decode`协议函数时类型不匹配或者没有导致解析失败问题
///
/// 目前只支持了`String`,`Int`,`CGFloat`,`Bool`等少数类型
///
/// 用法:
///
///     class SuperClass: Codable {
///         var name: MMSTypeWrap<String>
///         var sex: MMSTypeWrap<String>
///         var age: MMSTypeWrap<Int>
///         var xx: MMSTypeWrap<String>
///
///         private enum CodingKeys: String, KeyedKey {
///             case name, sex, age, xx
///         }
///
///         // 如果不涉及继承，这个可以不写
///         required init(from decoder: Decoder) throws {
///             let container = try decoder.container(keyedBy: CodingKeys.self)
///             name = try container.decode(MMSTypeWrap.self, forKey: .name)
///             sex = try container.decode(MMSTypeWrap.self, forKey: .sex)
///             age = try container.decode(MMSTypeWrap.self, forKey: .age)
///             xx = try container.decode(MMSTypeWrap.self, forKey: .xx)
///     }
///
public struct MMSTypeWrap<T>: Codable {
    
    var intValue: Int = 0
    var stringValue: String = ""
    var floatValue: CGFloat = 0.0
    var boolValue: Bool = false
    
    public init(_ value: MMSWrapTypeProtocol) {
        if let value = value as? String {
            intValue = Int(value) ?? 0
            self.stringValue = value
            floatValue = CGFloat(Double(value) ?? 0.0)
            boolValue = floatValue != 0
        } else if let value = value as? Int {
            self.intValue = value
            stringValue = String(value)
            floatValue = CGFloat(value)
            boolValue = value != 0
        } else if let value = value as? Double {
            intValue = Int(value)
            stringValue = String(value)
            self.floatValue = CGFloat(value)
            boolValue = floatValue != 0
        } else if let value = value as? CGFloat {
            intValue = Int(value)
            stringValue = String(Double(value))
            self.floatValue = value
            boolValue = floatValue != 0
        } else if let value = value as? Bool {
            intValue = value ? 1 : 0
            stringValue = value ? "1" : "0"
            floatValue = value ? 1.0 : 0.0
            self.boolValue = value
        }
    }
    
    // MARK: - Decodable
    
    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let aValue = try? singleValueContainer.decode(String.self) {
            stringValue = aValue
            if let intValue = Int(aValue) {
                self.intValue = intValue
                floatValue = CGFloat(intValue)
            } else if let doubleValue = Double(aValue) {
                intValue = Int(doubleValue)
                floatValue = CGFloat(doubleValue)
            }
            
            switch stringValue.lowercased() {
            case "0", "false", "null", "<null>", "no", "n":
                boolValue = false
            case "1", "true", "yes", "y":
                boolValue = true
            default:
                boolValue = false
            }
            
        } else if let intValue = try? singleValueContainer.decode(Int.self) {
            self.intValue = intValue
            self.stringValue = String(intValue)
            self.floatValue = CGFloat(intValue)
            boolValue = intValue != 0
        } else if let doubleValue = try? singleValueContainer.decode(CGFloat.self) {
            self.intValue = Int(doubleValue)
            self.stringValue = String(Double(doubleValue))
            self.floatValue = doubleValue
            boolValue = doubleValue != 0.0
        } else {
            self.intValue = 0
            self.stringValue = String(0)
            self.floatValue = CGFloat(0)
            boolValue = false
        }
    }
    
    // MARK: - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(intValue)
        try container.encode(floatValue)
        try container.encode(stringValue)
        try container.encode(boolValue)
    }
    
    // MARK: - Func
    
    public static func &= (lhs: inout MMSTypeWrap, rhs: MMSWrapTypeProtocol) {
        lhs = MMSTypeWrap(rhs)
    }
}

// MARK: - Literal

extension MMSTypeWrap: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = Self.init(value)
    }
}

extension MMSTypeWrap: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = Self.init(value)
    }
}

extension MMSTypeWrap: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self = Self.init(CGFloat(value))
    }
}

extension MMSTypeWrap: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = Self.init(value)
    }
}

extension MMSTypeWrap: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = Self.init(0)
    }
}

// MARK: - Prefix Operator Func

extension String {
    public static prefix func * (_ value: Self) -> MMSTypeWrap<Self> {
        return MMSTypeWrap(value)
    }
}

extension Int {
    public static prefix func * (_ value: Self) -> MMSTypeWrap<Self> {
        return MMSTypeWrap(value)
    }
}

extension CGFloat {
    public static prefix func * (_ value: Self) -> MMSTypeWrap<Self> {
        return MMSTypeWrap(value)
    }
}

extension Bool {
    public static prefix func * (_ value: Self) -> MMSTypeWrap<Self> {
        return MMSTypeWrap(value)
    }
}
