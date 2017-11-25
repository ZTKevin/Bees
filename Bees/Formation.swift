//
//  Formation.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import Foundation

infix operator ~ : BeeLayoutPriorityPrecedence

precedencegroup BeeLayoutPriorityPrecedence {
    associativity: left
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

extension Bee {
    static func createLayoutConstraints(lhs: Bee, rhs: Bee, relation: NSLayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()
        
        if lhs.pollensCount != rhs.pollensCount {
            print("Bees: left attributes count != right attributes count")
        } else {
            let item = lhs.target
            let toItem = rhs.target
            
            (item as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            
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
    
    static func createLayoutConstraints(lhs: Bee, rhs: [CGFloat], relation: NSLayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()

        if lhs.pollensCount != rhs.count {
            print("Bees: left attributes count != right attributes count")
        } else {
            let item = lhs.target
            
            (item as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            
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
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: Bee) -> [NSLayoutConstraint] {
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: Bee) -> [NSLayoutConstraint] {
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
    }
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: [CGFloat]) -> [NSLayoutConstraint] {
        let layoutConstraints = self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
        
        for layoutConstraint in layoutConstraints {
            layoutConstraint.isActive = true
        }
        return layoutConstraints
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
    
    public static func ~(lhs: Bee, rhs: UILayoutPriority) -> Bee {
        for pollen in lhs.pollens {
            pollen.priority = rhs
        }
        return lhs
    }
    
    public static func ~(lhs: Bee, rhs: Float) -> Bee {
        return lhs ~ UILayoutPriority(rhs)
    }
}

