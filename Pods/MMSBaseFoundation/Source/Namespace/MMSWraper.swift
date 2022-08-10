//
//  MMS.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2020/11/10.
//

import Foundation

public struct MMSWraper<T> {
    
    /// Base object to extend.
    public var base: T

    /// Creates extensions with base object.
    public init(_ base: T) {
        self.base = base
    }
}

public protocol MMSAny {

    associatedtype MMSType

    var mms: MMSWraper<MMSType> { get set }

    static var mms: MMSWraper<MMSType>.Type { get set }
}

public extension MMSAny {

    var mms: MMSWraper<Self> {
        get {
            return MMSWraper(self)
        }
        set { }
    }

    static var mms: MMSWraper<Self>.Type {
        get {
            return MMSWraper<Self>.self
        }
        set { }
    }
}
