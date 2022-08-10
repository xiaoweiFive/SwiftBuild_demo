//
//  URL+MMSUtility.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2020/11/18.
//

import Foundation

/// 字符串直接转为`URL`
/// - Note: example: `let url: URL = "www.google.com"` or `let url = "www.google.com" as URL`
extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }
}
