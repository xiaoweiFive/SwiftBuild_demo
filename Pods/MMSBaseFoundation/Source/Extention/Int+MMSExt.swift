//
//  Int+MMSExt.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/2/25.
//

import Foundation

/// Bool -> Int
extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value ? 1 : 0)
    }
}
