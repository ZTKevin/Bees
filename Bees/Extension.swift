//
//  Extension.swift
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

import Foundation

public extension Bee {

    public var size: Bee {
        return self.width.height
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
        return self.centerX.centerY
    }
    
    
    public var edge: Bee {
        return self.top.left.bottom.right
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

