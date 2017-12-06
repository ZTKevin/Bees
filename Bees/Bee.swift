//
//  Bee.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//
//  Copyright (c) 2017 Caiyu Hong <hongcaiyu@live.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#if os(macOS)
    import AppKit
    public typealias View = NSView
    @available(OSX 10.11, *)
    public typealias LayoutGuide = NSLayoutGuide
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public typealias LayoutAttribute = NSLayoutConstraint.Attribute
    
#else
    import UIKit
    public typealias View = UIView
    @available(iOS 9.0, tvOS 9.0, *)
    public typealias LayoutGuide = UILayoutGuide
    public typealias LayoutPriority = UILayoutPriority
    public typealias LayoutAttribute = NSLayoutAttribute
#endif



public class Bee: Sequence {
    
    public class Pollen {
        let attribute : LayoutAttribute
        
        var multiplier: CGFloat = 1
        
        var constant: CGFloat = 0
        
        var priority: LayoutPriority? = nil
        
        var next: Pollen? = nil

        init(attribute : LayoutAttribute) {
            self.attribute = attribute
        }
    }
    
    public struct Iterator: IteratorProtocol {
        
        private var current: Pollen?
    
        public mutating func next() -> Pollen? {
            let next = current
            current = current?.next
            return next
        }
        
        init(pollen: Pollen?) {
            self.current = pollen
        }
    }
    
    
    let target: Any
  
    private var head: Pollen? = nil
    private var tail: Pollen? = nil
    private(set) var count = 0
    
    init(target: Any) {
        self.target = target
    }
    
    var last: Pollen? {
        return tail
    }
    
    
    func enqueue(pollen: Pollen) -> Bee {
        count += 1
        if let tail = tail {
            tail.next = pollen
        }else{
            head = pollen
        }
        tail = pollen
        return self
    }
    
    func dequeue() -> Pollen? {
        if let head = head {
            count -= 1
            self.head = head.next
            if self.head == nil {
                self.tail = nil
            }
            return head
        }
        return nil
    }
    
    public func makeIterator() -> Bee.Iterator {
        return Iterator(pollen: self.head)
    }
    
}



public extension View {
    public var bee: Bee {
        return Bee(target: self)
    }
}

@available(iOS 9.0, OSX 10.11, tvOS 9.0, *)
public extension LayoutGuide {
    public var bee: Bee {
        return Bee(target: self)
    }
}

public extension Bee {
    public var top: Bee {
        return self.enqueue(pollen: Pollen(attribute: .top))
    }
    
    public var bottom: Bee {
        return self.enqueue(pollen: Pollen(attribute: .bottom))
    }
    
    public var left: Bee {
        return self.enqueue(pollen: Pollen(attribute: .left))
    }
    
    public var right: Bee {
        return self.enqueue(pollen: Pollen(attribute: .right))
    }
    
    public var width: Bee {
        return self.enqueue(pollen: Pollen(attribute: .width))
    }
    
    public var height: Bee {
        return self.enqueue(pollen: Pollen(attribute: .height))
    }
    
    public var leading: Bee {
        return self.enqueue(pollen: Pollen(attribute: .leading))
    }
    
    public var trailing: Bee {
        return self.enqueue(pollen: Pollen(attribute: .trailing))
    }
    
    public var centerX: Bee {
        return self.enqueue(pollen: Pollen(attribute: .centerX))
    }
    
    public var centerY: Bee {
        return self.enqueue(pollen: Pollen(attribute: .centerY))
    }
    
    public var lastBaseline: Bee {
        return self.enqueue(pollen: Pollen(attribute: .lastBaseline))
    }
    
    @available(iOS 9.0, OSX 10.11, tvOS 9.0, *)
    public var firstBaseline: Bee {
        return self.enqueue(pollen: Pollen(attribute: .firstBaseline))
    }
    
    #if os(iOS) || os(tvOS)
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var leftMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .leftMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var rightMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .rightMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var topMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .topMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var bottomMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .bottomMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var leadingMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .leadingMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var trailingMargin: Bee {
        return self.enqueue(pollen: Pollen(attribute: .trailingMargin))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var centerXWithinMargins: Bee {
        return self.enqueue(pollen: Pollen(attribute: .centerXWithinMargins))
    }
    
    @available(iOS 8.0, tvOS 9.0, *)
    public var centerYWithinMargins: Bee {
        return self.enqueue(pollen: Pollen(attribute: .centerYWithinMargins))
    }
    
    #endif
    
}

