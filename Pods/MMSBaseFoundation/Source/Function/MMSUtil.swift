//
//  MMSUtil.swift
//  MMSBaseFoundation
//
//  Created by ji.linlin on 2021/1/14.
//

import UIKit

public enum MMSUtil {}

public extension MMSUtil {
    
    // https://twitter.com/johnsundell/status/1055562781070684162
    func combine<A, B>(_ value: A, with closure: @escaping (A) -> B) -> () -> B {
        return { closure(value) }   // <==> { () in closure(value) }
    }
    
    /// 字符串格式化
    static func stringFormat(_ string: String?, defaultString: String? = "") -> String {
        if isStringNil(string) {
            if self.isStringNil(defaultString) {
                return ""
            }
            return defaultString!
        }
        return string!
    }
}

// MARK: - Thread
public extension MMSUtil {
    
    static func isMainThread() -> Bool {
        return 0 != pthread_main_np()
    }

    static func assertMainThread() {
        assert(isMainThread(), "Must execute on main thread")
    }

    static func executeOnMainThread(_ closure: @escaping ()-> Void) {
        if isMainThread() {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}

// MARK: - Verify
public extension MMSUtil {

    /// 字符串是否为空
    static func isStringNil(_ string: String?) -> Bool {
        if let str = string {
            return str.isEmpty
        }
        return false
    }
    
    /// array是否为空
    static func isArrayNil(_ array: Array<Any?>?) -> Bool {
        if let arr = array, arr.count > 0 {
            return true
        }
        return false
    }
    
    /// 判断是否是整数
    static func isInt(float: Float) -> Bool {
        if floor(float) == ceil(float) { // 向下取整 == 向上取整
            return true
        }
        return false
    }
}
