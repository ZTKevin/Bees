//
//  EdgeBee.swift
//  Bees
//
//  Created by hongcaiyu on 15/1/18.
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
    public typealias EdgeInsets = NSEdgeInsets
#else
    import UIKit
    public typealias EdgeInsets = UIEdgeInsets
#endif



public extension QueenBee {
    public var edge: EdgeBee {
        return EdgeBee(queenBee: self)
    }
}

public class EdgeBee: Formation {
    public typealias ConstraintsType =   (top: LayoutConstraint,
                                        left: LayoutConstraint,
                                        bottom: LayoutConstraint,
                                        right: LayoutConstraint)
    
    
    let left: Pollen
    let top: Pollen
    let right: Pollen
    let bottom: Pollen

    init(queenBee: QueenBee) {
        self.left = Pollen(attribute: .left, bee: queenBee)
        self.top = Pollen(attribute: .top, bee: queenBee)
        self.right = Pollen(attribute: .right, bee: queenBee)
        self.bottom = Pollen(attribute: .bottom, bee: queenBee)
    }
    
    public func inset(_ insets: EdgeInsets) -> EdgeBee {
        return self.inset(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    }
    
    public func inset(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> EdgeBee {
        self.left.add(left)
        self.top.add(top)
        self.bottom.sub(bottom)
        self.right.sub(right)
        return self
    }
    
    public static func makeConstraints(lhs: EdgeBee, rhs: EdgeBee, relation: LayoutRelation) -> (top: LayoutConstraint, left: LayoutConstraint, bottom: LayoutConstraint, right: LayoutConstraint) {
        let top = Pollen.makeConstraint(lhs: lhs.top, rhs: rhs.top, relation: relation)
        let left = Pollen.makeConstraint(lhs: lhs.left, rhs: rhs.left, relation: relation)
        let bottom = Pollen.makeConstraint(lhs: lhs.bottom, rhs: rhs.bottom, relation: relation)
        let right = Pollen.makeConstraint(lhs: lhs.right, rhs: rhs.right, relation: relation)
        return (top: top,
                left: left,
                bottom: bottom,
                right: right)
    }
    
    public static func prioritize(lhs: EdgeBee, rhs: LayoutPriority) {
        lhs.top.prioritize(rhs)
        lhs.left.prioritize(rhs)
        lhs.bottom.prioritize(rhs)
        lhs.right.prioritize(rhs)
    }
}
