//
//  Array+MMSExtention.swift
//  MMSBaseFoundation
//
//  Created by Zero.D.Saber on 2021/1/6.
//

import Foundation

public extension MMSWraper where T == [Any] {
    
    /// 取值，并设置非空的默认值
    subscript(index: Int, defaultValue: T.Element?) -> T.Element? {
        guard index >= 0, self.base.count > index else {
            return defaultValue
        }
        return self.base[index]
    }
    
    /// 取值，并设置非空的默认值
    func objectAtIndex(_ index: Int, defaultValue: T.Element?) -> T.Element? {
        guard index >= 0, self.base.count > index else {
            return defaultValue
        }
        return self.base[index]
    }
    
}

public extension Array {
    mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    
    /// 安全存值
    mutating func addSafe(_ object: Element?) {
        if let obj = object {
            self.append(obj)
        }
    }
    
    /// 取值，并设置非空的默认值
    func objectAtIndex(_ index: Int, defaultValue: Element?) -> Element? {
        guard startIndex..<endIndex ~= index else {
            return defaultValue
        }
        return self[index]
    }
}
