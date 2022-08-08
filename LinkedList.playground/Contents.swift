import Foundation
import UIKit

final class Node<T> {
    
    
    let payload: T
    var nextNode: Node?
    
    init(payload: T, nextNode: Node? = nil) {
        self.payload = payload
        self.nextNode = nextNode
    }
    
}

final class SinglyLinkedList<T> {
    
    var firstNode: Node<T>?
    
    init(firstNode: Node<T>? = nil) {
        self.firstNode = firstNode
    }
    
}

extension SinglyLinkedList {
    
    func reverseRecursively() {
        func reverse(_ node: Node<T>?) -> Node<T>? {
            guard let head = node else { return node }
            if head.nextNode == nil { return head }
            
            let reversedHead = reverse(head.nextNode)
            head.nextNode?.nextNode = head
            head.nextNode = nil
            
            return reversedHead
        }
        
        firstNode = reverse(firstNode)
    }
    
}

let node = Node(payload: 0)
let list = SinglyLinkedList(firstNode: node)

var currentNode = node
var nextNode: Node<Int>
for id in 1..<10 {
    nextNode = Node(payload: id)
    currentNode.nextNode = nextNode
    currentNode = nextNode
}



extension Node: CustomStringConvertible where T == Int {
    
    var description: String {
        let firstPart = """
        Node \(Unmanaged.passUnretained(self).toOpaque()) has id \(payload) and
        """
        if let nextNode = nextNode {
            return firstPart + " next node \(nextNode.payload)."
        } else {
            return firstPart + " no next node."
        }
    }
    
}

extension SinglyLinkedList: CustomStringConvertible where T == Int {
    
    var description: String {
        var description = """
        List \(Unmanaged.passUnretained(self).toOpaque())
        """
        if firstNode != nil {
            description += " has nodes:\n"
            
            var node = firstNode
            while node != nil {
                description += (node!.description + "\n")
                node = node!.nextNode
            }
            
            return description
        } else {
            return description + " has no nodes."
        }
    }
    
}

// MARK: - Односвязный список
print(String(describing: list))

// MARK: - разворот нашего односвязного списка
list.reverseRecursively()

// MARK: - Наш список после разворота
print(String(describing: list))
