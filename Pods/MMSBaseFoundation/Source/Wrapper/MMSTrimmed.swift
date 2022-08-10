//
//  MMSTrimmed.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 字符串通过属性包装器自动去除前后空格
///
/// @MMSTrimmed(wrappedValue: "默认值") var userName: String
///
/// userName = " 我会自动去除前后空格 "
///
/// print(userName): "我会自动去除前后空格"
///
@propertyWrapper
public struct MMSTrimmed {
    private(set) var value: String = ""

    public var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    public init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}
