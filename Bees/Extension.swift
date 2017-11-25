//
//  Extension.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import Foundation

public extension Bee {

    public var size: Bee {
        return self.append(pollen: Pollen(attribute: .width)).append(pollen: Pollen(attribute: .height))
    }

    @discardableResult
    public static func >=(lhs: Bee, rhs: CGSize) -> [NSLayoutConstraint] {
        return lhs >= [rhs.width, rhs.height]
    }
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: CGSize) -> [NSLayoutConstraint] {
        return lhs == [rhs.width, rhs.height]
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: CGSize) -> [NSLayoutConstraint] {
        return lhs <= [rhs.width, rhs.height]
    }
    
    
    
    public var center: Bee {
        return self.append(pollen: Pollen(attribute: .centerX)).append(pollen: Pollen(attribute: .centerY))
    }
    
    
    public var edge: Bee {
        return self.append(pollen: Pollen(attribute: .top))
        .append(pollen: Pollen(attribute: .left))
        .append(pollen: Pollen(attribute: .bottom))
        .append(pollen: Pollen(attribute: .right))
    }
    
    @discardableResult
    public static func ==(lhs: Bee, rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = (lhs.target as? UIView)?.superview else { return [] }
        return lhs == superview.bee.top.add(rhs.top).left.add(rhs.left).bottom.sub(rhs.bottom).right.sub(rhs.right)
    }
    
    @discardableResult
    public static func >=(lhs: Bee, rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = (lhs.target as? UIView)?.superview else { return [] }
        return lhs >= superview.bee.top.add(rhs.top).left.add(rhs.left).bottom.sub(rhs.bottom).right.sub(rhs.right)
    }
    
    @discardableResult
    public static func <=(lhs: Bee, rhs: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = (lhs.target as? UIView)?.superview else { return [] }
        return lhs <= superview.bee.top.add(rhs.top).left.add(rhs.left).bottom.sub(rhs.bottom).right.sub(rhs.right)
    }
}

