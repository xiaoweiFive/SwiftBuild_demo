//
//  MMSStack.swift
//  MMSBaseFoundation
//
//  Created by Jack on 2021/2/7.
//

import Foundation

struct MMSStack<Element> {
    private var elements: [Element] = []
    init() { }
}

extension MMSStack: CustomStringConvertible {
    var description: String {
        let topDivider = "====top====\n"
        let bottomDivider = "\n====bottom====\n"
        let MMSStackElements = elements
            .reversed()
            .map { "\($0)" }
            .joined(separator: "\n")
        return topDivider + MMSStackElements + bottomDivider
    }
}

// MARK: - Push & Pop
extension MMSStack {
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

// MARK: - Getters
extension MMSStack {
    var top: Element? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
}
