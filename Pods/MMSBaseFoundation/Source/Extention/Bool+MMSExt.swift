//
//  Bool+MMSExt.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/2/25.
//

import Foundation

/// Int -> Bool
extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value != 0)
    }
}
