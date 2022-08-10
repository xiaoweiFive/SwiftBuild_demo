//
//  MMSDefault.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

public protocol MMSDefaultValue {
    /// conflict with Dictionary's Value
    /// so change to `DFValue(default value)`
    associatedtype DFValue: Codable
    
    static var defaultValue: DFValue { get }
}

#if swift(>=5.1)
/// 为属性提供默认值
///
/// [属性包装器介绍](https://swiftgg.gitbook.io/swift/swift-jiao-cheng/10_properties#property-wrappers)
///
/// ## example:
///
///     class Example {
///         @MMSDefault<Int.Empty> var a: Int
///         @MMSDefault<String.Empty>("hello world") var text: String
///         @MMSDefault<Empty> var emptyString: String
///         @MMSDefault<Empty> var emptyArray: [String]
///     }
///
@propertyWrapper
public struct MMSDefault<T: MMSDefaultValue> {
    public var wrappedValue: T.DFValue
    
    public init() {
        self.wrappedValue = T.defaultValue
    }
    
    public init(wrappedValue: T.DFValue) {
        self.wrappedValue = wrappedValue
    }
}

public extension MMSDefault {
    typealias True = MMSDefault<Bool.True>
    typealias False = MMSDefault<Bool.False>
    typealias StrEmpty = MMSDefault<String.Empty>
    typealias IntEmpty = MMSDefault<Int.Empty>
}

extension MMSDefault: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            wrappedValue = T.defaultValue
        } else {
            self.wrappedValue = (try? container.decode(T.DFValue.self)) ?? T.defaultValue
        }
    }
}

extension MMSDefault: Equatable where T.DFValue: Equatable {}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: MMSDefault<T>.Type,
        forKey key: Key
    ) throws -> MMSDefault<T> where T: MMSDefaultValue {
        (try? decodeIfPresent(type, forKey: key)) ?? MMSDefault(wrappedValue: T.defaultValue)
    }
}
#endif

public extension Bool {
    enum False: MMSDefaultValue {
        public static let defaultValue = false
    }
    
    enum True: MMSDefaultValue {
        public static let defaultValue = true
    }
}

/// 默认为`""`
public extension String {
    /// Empty "".count = 0
    enum Empty: MMSDefaultValue {
        public static let defaultValue = ""
    }
}

/// 默认为`0`
public extension Int {
    enum Empty: MMSDefaultValue {
        public static let defaultValue = 0
    }
}

/// 默认为`0.0`
public extension Double {
    enum Empty: MMSDefaultValue {
        public static let defaultValue = 0.0
    }
}

/// 默认为`0.0`
public extension Float {
    enum Empty: MMSDefaultValue {
        public static let defaultValue = 0.0
    }
}

/// 默认为`0.0`
public extension CGFloat {
    enum Empty: MMSDefaultValue {
        public static let defaultValue = 0.0
    }
}

/// 默认为空数组
public extension Array {
    enum Empty<Element>: MMSDefaultValue where Element: Codable, Element: Equatable {
        public static var defaultValue: [Element] {
            [Element]()
        }
    }
}

/// 默认为空字典
extension Dictionary {
    enum Empty<K, V>: MMSDefaultValue where K: Codable & Hashable, V: Codable & Equatable {
        public static var defaultValue: [K: V] {
            [K: V]()
        }
    }
}

/// 默认空集合，e.g: `String`, `Array` ...
public enum Empty<T>: MMSDefaultValue where T: Codable, T: Equatable, T: RangeReplaceableCollection {
    public static var defaultValue: T {
        return T()
    }
}
