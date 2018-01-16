//
//  SizeBee.swift
//  Bees
//
//  Created by hongcaiyu on 11/1/18.
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
#else
    import UIKit
#endif

public extension QueenBee {
    public var size: SizeBee {
        return SizeBee(queenBee: self)
    }
}

public struct SizeConstraintSet: ConstraintSet {
    public let width: LayoutConstraint
    public let height: LayoutConstraint
    
    public func activate() {
        width.isActive = true
        height.isActive = true
    }
    
    public func deactivate() {
        width.isActive = false
        height.isActive = false
    }
    
}


public class SizeBee: Formation {
    
    public typealias ConstraintsType = SizeConstraintSet
    
    private let width: Pollen
    private let height: Pollen

    init(queenBee: QueenBee) {
        self.width = Pollen(attribute: .width, bee: queenBee)
        self.height = Pollen(attribute: .height, bee: queenBee)
    }
    
    public func mul(width: CGFloat = 1, height: CGFloat = 1) -> SizeBee {
        self.width.mul(width)
        self.height.mul(height)
        return self
    }
    
    public func add(width: CGFloat = 0, height: CGFloat = 0) -> SizeBee {
        self.width.add(width)
        self.height.add(height)
        return self
    }
    
    public static func makeConstraints(lhs: SizeBee, rhs: SizeBee, relation: LayoutRelation) -> SizeConstraintSet {
        let widthConstraint = Pollen.makeConstraint(lhs: lhs.width, rhs: rhs.width, relation: relation)
        let heightConstraint = Pollen.makeConstraint(lhs: lhs.height, rhs: rhs.height, relation: relation)
        return SizeConstraintSet(width: widthConstraint, height: heightConstraint)
    }
    
    public static func prioritize(lhs: SizeBee, rhs: LayoutPriority) {
        lhs.width.prioritize(rhs)
        lhs.height.prioritize(rhs)
    }
    
    private static func makeConstraints(lhs: SizeBee, rhs: CGSize, relation: LayoutRelation) -> SizeConstraintSet {
        let widthConstraint = Pollen.makeConstraint(lhs: lhs.width, rhs: rhs.width, relation: relation)
        let heightConstraint = Pollen.makeConstraint(lhs: lhs.height, rhs: rhs.height, relation: relation)
        return SizeConstraintSet(width: widthConstraint, height: heightConstraint)
    }
    
    @discardableResult
    public static func ==(lhs: SizeBee, rhs: CGSize) -> SizeConstraintSet {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: SizeBee, rhs: CGSize) -> SizeConstraintSet {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: SizeBee, rhs: CGSize) -> SizeConstraintSet {
        return self.makeConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
}


