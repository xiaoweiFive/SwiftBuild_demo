//
//  MMSEdgeFade.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

/// 边缘渐隐
public struct MMSEdgeFade: OptionSet {
    
    public typealias EdgeFade = MMSEdgeFade
    
    static let leading = EdgeFade(rawValue: 1)
    
    static let trailing = EdgeFade(rawValue: 1)
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}
