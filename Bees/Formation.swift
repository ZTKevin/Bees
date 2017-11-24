//
//  Formation.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import Foundation

public extension Bee {
    public static func ==(lhs: Bee, rhs: Bee) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func >=(lhs: Bee, rhs: Bee) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func <=(lhs: Bee, rhs: Bee) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func ==(lhs: Bee, rhs: [CGFloat]) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func >=(lhs: Bee, rhs: [CGFloat]) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func <=(lhs: Bee, rhs: [CGFloat]) {
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func ==(lhs: Bee, rhs: CGFloat) {
        let rhs = [CGFloat](repeating: rhs, count: lhs.pollensCount)
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .equal) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func >=(lhs: Bee, rhs: CGFloat) {
        let rhs = [CGFloat](repeating: rhs, count: lhs.pollensCount)
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func <=(lhs: Bee, rhs: CGFloat) {
        let rhs = [CGFloat](repeating: rhs, count: lhs.pollensCount)
        for layoutConstraint in self.createLayoutConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual) {
            layoutConstraint.isActive = true
        }
    }
    
    public static func createLayoutConstraints(lhs: Bee, rhs: Bee, relation: NSLayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()
        
        if lhs.pollensCount != rhs.pollensCount {
            print("Bees: lhs.pollensCount != rhs.pollensCount")
        } else {
            let item = lhs.target
            let toItem = rhs.target
            
            (item as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            
            for index in 0..<lhs.pollensCount{
                let leftPollen = lhs.pollens[index]
                let rightPollen = lhs.pollens[index]
                
                let multiplier = rightPollen.multiplier / leftPollen.multiplier
                let constant = rightPollen.constant - leftPollen.constant
                
                let layoutConstraint = NSLayoutConstraint(item: item,
                                                          attribute: leftPollen.attribute,
                                                          relatedBy: relation,
                                                          toItem: toItem,
                                                          attribute: rightPollen.attribute,
                                                          multiplier: multiplier,
                                                          constant: constant)
                layoutConstraints.append(layoutConstraint)
            }
        }
        
        return layoutConstraints
    }
    
    public static func createLayoutConstraints(lhs: Bee, rhs: [CGFloat], relation: NSLayoutRelation) -> [NSLayoutConstraint]{
        var layoutConstraints = [NSLayoutConstraint]()

        if lhs.pollensCount != rhs.count {
            print("Bees: lhs.pollensCount != rhs.count")
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
                layoutConstraints.append(layoutConstraint)
            }
        }
        
        return layoutConstraints
    }
}
