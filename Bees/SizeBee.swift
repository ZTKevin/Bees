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

public class SizeBee: Formation {
    
    public typealias ConstraintSet = (width: LayoutConstraint, height: LayoutConstraint)
    
    let width: Pollen
    let height: Pollen

    init(queenBee: QueenBee) {
        self.width = Pollen(attribute: .width, bee: queenBee)
        self.height = Pollen(attribute: .height, bee: queenBee)
    }
    
    public static func makeActiveConstraints(lhs: SizeBee, rhs: SizeBee, relation: LayoutRelation) -> (width: LayoutConstraint, height: LayoutConstraint) {
        let widthConstraint = Pollen.makeConstraint(lhs: lhs.width, rhs: rhs.width, relation: relation)
        let heightConstraint = Pollen.makeConstraint(lhs: lhs.height, rhs: rhs.height, relation: relation)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        return (width: widthConstraint, height: heightConstraint)
    }
    
    public static func prioritize(lhs: SizeBee, rhs: LayoutPriority) {
        lhs.width.prioritize(rhs)
        lhs.height.prioritize(rhs)
    }
    
    private static func makeActiveConstraints(lhs: SizeBee, rhs: CGSize, relation: LayoutRelation) -> (width: LayoutConstraint, height: LayoutConstraint) {
        let widthConstraint = Pollen.makeConstraint(lhs: lhs.width, rhs: rhs.width, relation: relation)
        let heightConstraint = Pollen.makeConstraint(lhs: lhs.height, rhs: rhs.height, relation: relation)
        widthConstraint.isActive = true
        heightConstraint.isActive = true
        return (width: widthConstraint, height: heightConstraint)
    }
    
    @discardableResult
    public static func ==(lhs: SizeBee, rhs: CGSize) -> (width: LayoutConstraint, height: LayoutConstraint) {
        return self.makeActiveConstraints(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    @discardableResult
    public static func >=(lhs: SizeBee, rhs: CGSize) -> (width: LayoutConstraint, height: LayoutConstraint) {
        return self.makeActiveConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
    }
    
    @discardableResult
    public static func <=(lhs: SizeBee, rhs: CGSize) -> (width: LayoutConstraint, height: LayoutConstraint) {
        return self.makeActiveConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
    }
    
}


