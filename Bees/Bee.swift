//
//  Bee.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//
//  Copyright (c) 2018 Caiyu Hong <hongcaiyu@live.com>
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
    public typealias LayoutConstraint = NSLayoutConstraint
    public typealias LayoutPriority = NSLayoutConstraint.Priority
    public typealias LayoutAttribute = NSLayoutConstraint.Attribute
    public typealias LayoutRelation = NSLayoutConstraint.Relation
#else
    import UIKit
    public typealias View = UIView
    @available(iOS 9.0, tvOS 9.0, *)
    public typealias LayoutGuide = UILayoutGuide
    public typealias LayoutConstraint = NSLayoutConstraint
    public typealias LayoutPriority = UILayoutPriority
    public typealias LayoutAttribute = NSLayoutConstraint.Attribute
    public typealias LayoutRelation = NSLayoutConstraint.Relation
#endif

infix operator ~ : BeeLayoutPriorityPrecedence

precedencegroup BeeLayoutPriorityPrecedence {
    associativity: left
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}


public struct QueenBee {
    let target: Any
}


public extension View {
    var bee: QueenBee {
        return QueenBee(target: self)
    }
}

@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
public extension LayoutGuide {
    var bee: QueenBee {
        return QueenBee(target: self)
    }
}

public protocol ConstraintSet {
    
    func activate()

    func deactivate()
}


public protocol Formation {
    associatedtype ConstraintsType: ConstraintSet
    
    static func makeConstraints(lhs: Self, rhs: Self, relation: LayoutRelation) -> ConstraintsType
    
    static func prioritize(lhs: Self, rhs: LayoutPriority)
}

public extension Formation {
    @discardableResult
    static func >=(lhs: Self, rhs: Self) -> ConstraintsType {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    static func <=(lhs: Self, rhs: Self) -> ConstraintsType {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
    @discardableResult
    static func ==(lhs: Self, rhs: Self) -> ConstraintsType {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    static func ~(lhs: Self, rhs: LayoutPriority) -> Self {
        self.prioritize(lhs: lhs, rhs: rhs)
        return lhs
    }
    
    static func ~(lhs: Self, rhs: Float) -> Self {
        return lhs ~ LayoutPriority(rhs)
    }
}



