//
//  MMSRecordData.swift
//  MMSBaseFoundation
//
//  Created by YinYuGuang on 2021/2/4.
//

import Foundation

/// 记录历史数据行为
/// 使用方式：@MMSRecordData var name: String = "MOMO"
/// name = "MOMO 1"
/// print(_name.values) : ["MOMO", "MOMO 1"]
///
@propertyWrapper
public struct MMSRecordData<Value> {
    
    private var index: Int
    public var values: [Value]
    
    public init(wrappedValue: Value) {
        self.values = [wrappedValue]
        self.index = 0
    }
    
    public var wrappedValue: Value {
        get {
            return values[index]
        }
        
        set {
            values.append(newValue)
            index += 1
        }
    }
}
