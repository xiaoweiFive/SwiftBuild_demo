//
//  MMSUI.swift
//  MMSUIBaseFoundation
//
//  Created by Zero.D.Saber on 2020/11/10.
//

import Foundation

public struct MMSUIWraper<T> {
    
    /// Base object to extend.
    public let base: T

    /// Creates extensions with base object.
    public init(_ base: T) {
        self.base = base
    }
}

public protocol MMSUIObject: AnyObject {
    
    associatedtype MMSUIObjectType: AnyObject
    
    /// 类变量
    static var mms: MMSUIWraper<MMSUIObjectType>.Type { get set }
    
    /// 实例变量
    var mms: MMSUIWraper<MMSUIObjectType> { get set }
}

extension MMSUIObject {
    
    public var mms: MMSUIWraper<Self> {
        get {
            return MMSUIWraper(self)
        }
        set { }
    }
    
    public static var mms: MMSUIWraper<Self>.Type {
        get {
            return MMSUIWraper<Self>.self
        }
        set { }
    }
}

/// NSObject默认遵守协议
extension NSObject: MMSUIObject {}
