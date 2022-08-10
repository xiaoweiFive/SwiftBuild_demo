//
//  MMSDelegate.swift
//  MMSBaseFoundation
//
//  Created by aiss on 2021/2/26.
//  https://onevcat.com/2020/03/improve-delegate/

public class MMSDelegate<Input, OutPut> {
    private var block: ((Input) -> OutPut?)?
    
    public func delegate<T: AnyObject>(on target: T, block: ((T, Input) -> OutPut)?) {
        self.block = { [weak target] input in
            guard let target = target else { return nil }
            return block?(target, input)
        }
    }
    
    public func call(_ input: Input) -> OutPut? {
        return block?(input)
    }
    
    #if swift(>=5.2)
    public func callAsFunction(_ input: Input) -> OutPut? {
        return block?(input)
    }
    #endif
    
    public init() {}
}

/* 处理OutPut双层可选值情况 */
public protocol OptionalProtocol {
    static var createNil: Self { get }
}

extension Optional: OptionalProtocol {
    public static var createNil: Optional<Wrapped> {
        return nil
    }
}

extension MMSDelegate where OutPut: OptionalProtocol {
    public func call(_ input: Input) -> OutPut {
        if let result = block?(input) {
            return result
        } else {
            return .createNil
        }
    }
    
    public func callAsFunction(_ input: Input) -> OutPut {
        if let result = block?(input) {
            return result
        } else {
            return .createNil
        }
    }
}
