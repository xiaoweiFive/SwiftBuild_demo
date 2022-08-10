//
//  MMSExpirableValue.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

///
/// 对一个属性进行时效设置, 在设置时进行倒计时, 过了时间再访问为 nil, 属性所修饰的是可选
///
/// 使用方式：@MMSExpirableValue(duration: 5) var name: String?
///
/// 举例：
/// name = "MOMO"
/// print(name) : MOMO
/// sleep(5) 5 秒后自动置为 nil
/// print("\(name) nil 已经被释放了"): nil 已经被释放了
///
@propertyWrapper
public struct MMSExpirableValue<Value> {
    
    public let duration: TimeInterval
    
    public var storage: (value: Value, expirationDate: Date)?
    
    public init(duration: TimeInterval) {
        self.duration = duration
        storage = nil
    }
    
    public var wrappedValue: Value? {
        get {
            isValid ? storage?.value : nil
        }
        set {
            storage = newValue.map { newValue in
                let expirationDate = Date().addingTimeInterval(duration)
                return (newValue, expirationDate)
            }
        }
    }
    
    public var isValid: Bool {
        guard let storage = storage else { return false }
        return storage.expirationDate >= Date()
    }
    
    public mutating func set(_ newValue: Value, expirationDate: Date) {
        storage = (newValue, expirationDate)
    }
}
