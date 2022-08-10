//
//  MMSNilPositioning.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 如果在构建参数的时候进行强制 ”!“ 的时候建议加上 MMSNilPositioning. 它会告诉你崩溃的原因
/// 当然不建议对未初始化的变量、常量加上 ”!“,
///
/// 使用方式: @MMSNilPositioning var name: String!
///
/// 未赋值直接使用会崩溃并提示: ”你还未给该值赋值就开始获取使用了“
///
@propertyWrapper
public struct MMSNilPositioning<Value> {
    var storage: Value?
    
    public init() {
        storage = nil
    }
    
    public var wrappedValue: Value {
        get {
            guard let storage = storage else {
                fatalError("你还未给该值赋值就开始获取使用了")
            }
            return storage
        }
        set {
            storage = newValue
        }
    }
}
