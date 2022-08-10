//
//  MMSChain.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/5/25.
//
//  链式调用

#if canImport(Foundation)
import Foundation

extension NSObject: MMSChainProtocol {}
#endif

@dynamicMemberLookup
public struct MMSChain<T> {
    
    private let base: T
    
    public init(_ base: T) {
        self.base = base
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> (Value) -> T {
        { value in
            var object = base
            object[keyPath: keyPath] = value
            return object
        }
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> (Value) -> MMSChain<T> {
        { value in
            var object = base
            object[keyPath: keyPath] = value
            return Self(object)
        }
    }
}

public protocol MMSChainProtocol {
    associatedtype T
    //@available(*, deprecated, renamed: "chain", message: "mms与其他的命名空间重名了, 经常联想不出来,用chain来代替")
    //var mms: MMSChain<T> { get set }
    var chain: MMSChain<T> { get set }
}

extension MMSChainProtocol {
    
    public var chain: MMSChain<Self> {
        get { MMSChain(self) }
        set {}
    }
}


