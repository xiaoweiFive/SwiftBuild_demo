//
//  Collection+MMSExtention.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/1/11.
//

import Foundation

public extension Collection {
    
    /// 安全取值
    /// - Parameters index: 下标
    /// - Notes 来源：https://github.com/Luur/SwiftTips
    subscript(mms index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// 安全取值并提供默认值
    /// - Parameters
    ///     - index: 下标
    ///     - defaultValue: 默认值
    /// - Notes
    subscript(mms index: Index, defaultValue: Element) -> Element {
        return indices.contains(index) ? self[index] : defaultValue
    }
}
