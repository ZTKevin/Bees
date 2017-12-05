//
//  Formation.swift
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
    public typealias LayoutRelation = NSLayoutConstraint.Relation
#else
    import UIKit
    public typealias LayoutRelation = NSLayoutRelation
#endif

infix operator ~ : BeeLayoutPriorityPrecedence

precedencegroup BeeLayoutPriorityPrecedence {
    associativity: left
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

extension Bee {
    static func createLayoutConstraints(lhs: Bee, rhs: Bee, relation: LayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()
        
        if lhs.pollensCount != rhs.pollensCount {
            print("Bees: left attributes count != right attributes count")
        } else {
            let item = lhs.target
            let toItem = rhs.target
            
            (item as? View)?.translatesAutoresizingMaskIntoConstraints = false
            
            for index in 0..<lhs.pollensCount{
                let leftPollen = lhs.pollens[index]
                let rightPollen = rhs.pollens[index]
                
                let multiplier = rightPollen.multiplier / leftPollen.multiplier
                let constant = rightPollen.constant - leftPollen.constant
                
                let layoutConstraint = NSLayoutConstraint(item: item,
                                                          attribute: leftPollen.attribute,
                                                          relatedBy: relation,
                                                          toItem: toItem,
                                                          attribute: rightPollen.attribute,
                                                          multiplier: multiplier,
                                                          constant: constant)
                if let priority = leftPollen.priority {
                    layoutConstraint.priority = priority
                } else if let priority = rightPollen.priority {
                    layoutConstraint.priority = priority
                }
                layoutConstraints.append(layoutConstraint)
            }
        }
        
        return layoutConstraints
    }
    
    static func createLayoutConstraints(lhs: Bee, rhs: [CGFloat], relation: LayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()

        if lhs.pollensCount != rhs.count {
            print("Bees: left attributes count != right attributes count")
        } else {
            let item = lhs.target
            
            (item as? View)?.translatesAutoresizingMaskIntoConstraints = false
            
            for index in 0..<lhs.pollensCount{
                let leftPollen = lhs.pollens[index]

                let multiplier = 1 / leftPollen.multiplier
                let constant = rhs[index] - leftPollen.constant
                
                let layoutConstraint = NSLayoutConstraint(item: item,
                                                          attribute: leftPollen.attribute,
                                                          relatedBy: relation,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: multiplier,
                                                          constant: constant)
                
                if let priority = leftPollen.priority {
                    layoutConstraint.priority = priority
                }
                layoutConstraints.append(layoutConstraint)
            }
        }
        
        return layoutConstraints
    }
}

public extension Bee {
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: Bee) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: Bee) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: Bee) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let constraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: CGFloat) -> [NSLayoutConstraint] {
        return lhs == [CGFloat](repeating: rhs, count: lhs.pollensCount)
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: CGFloat) -> [NSLayoutConstraint] {
        return lhs >= [CGFloat](repeating: rhs, count: lhs.pollensCount)
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: CGFloat) -> [NSLayoutConstraint] {
        return lhs <= [CGFloat](repeating: rhs, count: lhs.pollensCount)
    }
}

public extension Bee {
    public static func +(lhs: Bee, rhs: CGFloat) -> Bee {
        for pollen in lhs.pollens {
            pollen.constant += rhs
        }
        return lhs
    }

    public static func -(lhs: Bee, rhs: CGFloat) -> Bee{
        for pollen in lhs.pollens {
            pollen.constant -= rhs
        }
        return lhs
    }

    public static func *(lhs: Bee, rhs: CGFloat) -> Bee{
        for pollen in lhs.pollens {
            pollen.multiplier *= rhs
            pollen.constant *= rhs
        }
        return lhs
    }

    public static func /(lhs: Bee, rhs: CGFloat) -> Bee{
        for pollen in lhs.pollens {
            pollen.multiplier /= rhs
            pollen.constant /= rhs
        }
        return lhs
    }
    
    public static func ~(lhs: Bee, rhs: LayoutPriority) -> Bee {
        for pollen in lhs.pollens {
            pollen.priority = rhs
        }
        return lhs
    }
    
    public static func ~(lhs: Bee, rhs: Float) -> Bee {
        return lhs ~ LayoutPriority(rhs)
    }
}

