//
//  MMSCapitalized.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 字母首字母自动大写
///
/// 例如: @Capitalized var name: String = "hello"
///
/// print: "Hello"
@propertyWrapper
public struct MMSCapitalized {
    public var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}
