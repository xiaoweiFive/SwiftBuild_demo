//
//  MMSEmail.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 邮箱自动判断
///
/// 使用方式
///
/// @MMSEmail
/// var name1: String = "momo@immomo.com"
///
/// @MMSEmail
/// var name2: String = "momo"
///
/// print("\(name1) Empty: \(name1.isEmpty)")： momo@immomo.com isEmpty: false
/// print("\(name2) Empty: \(name2.isEmpty)")： "" isEmpty: true
@propertyWrapper
public struct MMSEmail<Value: StringProtocol> {

    public var value: Value

    public var wrappedValue: Value {
        get {
            return checkEmail(email: value) ? value : ""
        }
        set {
            value = newValue
        }
    }
    
    public init(wrappedValue initialValue: Value) {
        self.value = initialValue
        self.wrappedValue = initialValue
    }

    private func checkEmail(email: Value?) -> Bool {
        guard let email = email else { return false }
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailPred.evaluate(with: email)
    }
}
