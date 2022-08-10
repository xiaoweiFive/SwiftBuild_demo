//
//  MMSPriorityQueue.swift
//  MMSBaseFoundation
//
//  Created by Jack on 2021/2/7.
//

import Foundation

public struct MMSPriorityQueue<Element: Comparable> {
    
    private var heap: MMSHeap<Element>
    
    public init(ascending: Bool = false, startingValues: [Element] = []) {
        self.init(ordered: ascending ? { $0 > $1 } : { $0 < $1 }, startingValues: startingValues)
    }
    
    /// Creates a new MMSPriorityQueue with the given ordering.
    ///
    /// - parameter order: A function that specifies whether its first argument should
    ///                    come after the second argument in the MMSPriorityQueue.
    /// - parameter startingValues: An array of elements to initialize the MMSPriorityQueue with.
    public init(ordered: @escaping (Element, Element) -> Bool, startingValues: [Element] = []) {
        heap = MMSHeap(order: ordered, startingValues: startingValues)
    }
    
}

extension MMSPriorityQueue {
    /// Add a new element onto the Priority Queue. O(lg n)
    ///
    /// - parameter element: The element to be inserted into the Priority Queue.
    public mutating func push(_ element: Element) {
        heap.insert(element)
    }
    
    /// Remove and return the element with the highest priority (or lowest if ascending). O(lg n)
    ///
    /// - returns: The element with the highest priority in the Priority Queue, or nil if the MMSPriorityQueue is empty.
    @discardableResult
    public mutating func pop() -> Element? {
        return heap.removePeek()
    }
    
    // Get a look at the current highest priority item, without removing it. O(1)
    ///
    /// - returns: The element with the highest priority in the MMSPriorityQueue, or nil if the MMSPriorityQueue is empty.
    public func peek() -> Element? {
        return heap.peek
    }
    
    /// Eliminate all of the elements from the Priority Queue.
    public mutating func clear() {
        heap.clear()
    }
    
    @discardableResult
    mutating func remove(at index: Int) -> Element? {
        heap.remove(at: index)
    }
    
    /// Removes the first occurence of a particular item. Finds it by value comparison using ==. O(n)
    /// Silently exits if no occurrence found.
    ///
    /// - parameter item: The item to remove the first occurrence of.
    public mutating func remove(_ item: Element) {
        heap.removeFirstItem(item)
    }
    
    /// Removes all occurences of a particular item. Finds it by value comparison using ==. O(n)
    /// Silently exits if no occurrence found.
    ///
    /// - parameter item: The item to remove.
    public mutating func removeAll(_ item: Element) {
        heap.removeAll(item)
    }
    
}

// MARK: - GeneratorType
extension MMSPriorityQueue: IteratorProtocol {
    mutating public func next() -> Element? { return pop() }
}

// MARK: - SequenceType
extension MMSPriorityQueue: Sequence {
    
    public typealias Iterator = MMSPriorityQueue
    public func makeIterator() -> Iterator { return self }
}

// MARK: - CollectionType
extension MMSPriorityQueue: Collection {
    
    public typealias Index = Int
    
    public var startIndex: Int { return heap.startIndex }
    public var endIndex: Int { return heap.endIndex }
    
    public subscript(index: Int) -> Element { return heap[index] }
    
    public func index(after index: MMSPriorityQueue.Index) -> MMSPriorityQueue.Index {
        return heap.index(after: index)
    }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible
extension MMSPriorityQueue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { return heap.description }
    public var debugDescription: String { return heap.debugDescription }
}
