//
//  MMSLossyArray.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 数组的安全解析, 解决 Swift Codable 模型在 json 数据结构不对的情况下解析失败
///
/// 使用方式：只需要在数组面前加上
/// @MMSLossyArray var values: [Int]  即可
///
/// 举例: { "values": [1, 2, null, 4, 5, null, 6, 7, null,] }
/// 解析完: values = [1, 2, 4, 5, 6, 7]
///
@propertyWrapper
public struct MMSLossyArray<Value: Codable> {
    
    private struct AnyDecodableValue: Codable {}
    public var wrappedValue: [Value]
    
    public init(wrappedValue: [Value]) {
      self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements = [Value]()
        while !container.isAtEnd {
            do {
                let value = try container.decode(Value.self)
                elements.append(value)
            } catch _ {
                _ = try? container.decode(AnyDecodableValue.self)
            }
        }
        self.wrappedValue = elements
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension MMSLossyArray: Equatable where Value: Equatable {}
extension MMSLossyArray: Hashable where Value: Hashable {}
extension MMSLossyArray: Codable {}
