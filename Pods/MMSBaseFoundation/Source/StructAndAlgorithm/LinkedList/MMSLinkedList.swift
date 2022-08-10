//
//  MMSLinkedList.swift
//  MMSBaseFoundation
//
//  Created by Jack on 2021/2/8.
//

import Foundation

// MARK: - MMSLinkedListNode
final class MMSLinkedListNode<T> {
    var value: T
    var next: MMSLinkedListNode?
    
    init(value: T, next: MMSLinkedListNode? = nil) {
        self.value = value
        self.next = next
    }
}
extension MMSLinkedListNode: CustomStringConvertible {
    var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> \(String(describing: next)) "
    }
}

// MARK: - MMSLinkedList
struct MMSLinkedList<T> {
    var head: MMSLinkedListNode<T>?
    var tail: MMSLinkedListNode<T>?
    init() { }
    
    mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else { return }
        guard var oldNode = head else { return }

        head = MMSLinkedListNode(value: oldNode.value)
        var newNode = head

        while let nextOldNode = oldNode.next {
            let nextNewNode = MMSLinkedListNode(value: nextOldNode.value)
            newNode?.next = nextNewNode
            newNode = nextNewNode
            oldNode = nextOldNode
        }

        tail = newNode
    }
}
extension MMSLinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else { return "Empty list" }
        return String(describing: head)
    }
}

// MARK: - Add Values
extension MMSLinkedList {
    mutating func append(_ value: T) {
        copyNodes()
        
        guard !isEmpty else {
            let node = MMSLinkedListNode(value: value)
            head = node
            tail = node
            return
        }
        let next = MMSLinkedListNode(value: value)
        tail?.next = next
        tail = next
    }
    
    mutating func insert(_ value: T, after node: MMSLinkedListNode<T>) {
        copyNodes()
        guard tail !== node else { append(value); return }
        node.next = MMSLinkedListNode(value: value, next: node.next)
    }
}

// MARK: - Remove Values
extension MMSLinkedList {
    mutating func removeLast() -> T? {
        copyNodes()
        
        guard let head = head else { return nil }
        
        guard head.next != nil else {
            let headValue = head.value
            self.head = nil
            tail = nil
            return headValue
        }
        
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    
    mutating func remove(after node: MMSLinkedListNode<T>) -> T? {
        copyNodes()
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
}

// MARK: - Access Values
extension MMSLinkedList {
    func node(at index: Int) -> MMSLinkedListNode<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
}

// MARK: - Getters
extension MMSLinkedList {
    var isEmpty: Bool {
        return head == nil
    }
}

// MARK: - Collection
extension MMSLinkedList: Collection {
    
    struct Index: Comparable {
        var node: MMSLinkedListNode<T>?
        
        static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static func < (lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    var startIndex: Index {
        return Index(node: head)
    }
    
    var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    func index(after index: Index) -> Index {
        return Index(node: index.node?.next)
    }
    
    subscript(index: Index) -> T {
        return index.node!.value
    }
}
