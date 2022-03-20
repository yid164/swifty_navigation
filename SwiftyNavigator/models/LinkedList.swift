//
//  LinkedList.swift
//  SwiftyNavigator
//
//  Created by Yinsheng Dong on 2022-03-19.
//

import Foundation

// Resouce: https://www.raywenderlich.com/books/data-structures-algorithms-in-swift/v3.0/chapters/6-linked-list
public class Node<T> {
    public var value: T
    public var next: Node?
    
    public init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

public struct LinkedList<T> {
    public var head: Node<T>?
    public var tail: Node<T>?
    
    public init() {}
    
    public var isEmpty: Bool { return head == nil }
    
    public mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: T) {
        guard !isEmpty else { push(value); return }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func itemAt(at index: Int) -> Node<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    public mutating func insert(_ value: T, after node: Node<T>) -> Node<T> {
        guard tail !== node else { append(value); return tail! }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    public mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty { tail = nil }
        }
        return head?.value
    }
    
    public mutating func removeLast() -> T? {
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
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
    
    public mutating func remove(after node: Node<T>) -> T? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: Collection {
    public struct Index: Comparable {
      public var node: Node<T>?
      static public func ==(lhs: Index, rhs: Index) -> Bool {
        switch (lhs.node, rhs.node) {
        case let (left?, right?):
          return left.next === right.next
        case (nil, nil):
          return true
        default:
          return false
        }
      }
      
      static public func <(lhs: Index, rhs: Index) -> Bool {
        guard lhs != rhs else {
          return false
        }
        let nodes = sequence(first: lhs.node) { $0?.next }
        return nodes.contains { $0 === rhs.node }
      }
    }
    
    public var startIndex: Index {
      Index(node: head)
    }

    public var endIndex: Index {
      Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
      Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> T {
      position.node!.value
    }
}
