//
//  LinkBee.swift
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


public protocol LinkFormation: Formation where ConstraintSet == [LayoutConstraint] {


}

public class LinkBee {
    let linkBee: LinkBee?
    let pollen: Pollen
    
    init(linkBee: LinkBee?, pollen: Pollen) {
        self.linkBee = linkBee
        self.pollen = pollen
    }
    
    init(left: QueenBee, attribute: LayoutAttribute) {
        self.linkBee = nil
        self.pollen = Pollen(attribute: attribute, bee: left)
    }
    
    init(left: LinkBee, attribute: LayoutAttribute) {
        self.linkBee = left
        self.pollen = Pollen(attribute: attribute, bee: left.pollen.bee)
    }
}

public extension LinkFormation where Self: LinkBee {
    public func prioritize(_ priority: LayoutPriority) -> Self {
        self.pollen.prioritize(priority)
        return self
    }
    
    public func prioritize(_ priority: Float) -> Self {
        return self.prioritize(LayoutPriority(priority))
    }
    
    public func add(_ constant: CGFloat) -> Self {
        self.pollen.add(constant)
        return self
    }
    
    public func sub(_ constant: CGFloat) -> Self {
        self.pollen.sub(constant)
        return self
    }
    
    public func mul(_ multiplier: CGFloat) -> Self {
        self.pollen.mul(multiplier)
        return self
    }
    
    public func div(_ divisor: CGFloat) -> Self {
        self.pollen.div(divisor)
        return self
    }
    
    // MARK: Formation
    public static func makeActiveConstraints(lhs: Self, rhs: Self, relation: LayoutRelation) -> [LayoutConstraint] {
        var constraints = [LayoutConstraint]()
        func makeConstraints(lhs: LinkBee, rhs: LinkBee) {
            if let left = lhs.linkBee, let right = rhs.linkBee {
                makeConstraints(lhs: left, rhs: right)
            }
            let constraint = Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs.pollen, relation: relation)
            constraints.append(constraint)
        }
        
        makeConstraints(lhs: lhs, rhs: rhs)
        LayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    public static func prioritize(lhs: Self, rhs: LayoutPriority) {
        var bee: LinkBee? = lhs
        while let linkBee = bee {
            linkBee.pollen.prioritize(rhs)
            bee = linkBee.linkBee
        }
    }
}


public class YAxisLinkBee<Left>: LinkBee, LinkFormation {
    public typealias ConstraintSet = [LayoutConstraint]
}

public class XAxisLinkBee<Left>: LinkBee, LinkFormation {
    public typealias ConstraintSet = [LayoutConstraint]
}

public class DimensionLinkBee<Left>: LinkBee, LinkFormation {
    public typealias ConstraintSet = [LayoutConstraint]
}

public func ==(lhs: DimensionLinkBee<QueenBee>, rhs: CGFloat) -> LayoutConstraint {
    let constraint = Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs, relation: .equal)
    constraint.isActive = true
    return constraint
}

public func ==(lhs: DimensionLinkBee<DimensionLinkBee<QueenBee>>, rhs: (CGFloat, CGFloat)) -> (LayoutConstraint,LayoutConstraint) {
    let constraints = (Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs.1, relation: .equal),
                       Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs.0, relation: .equal))
    constraints.0.isActive = true
    constraints.1.isActive = true
    return constraints
}

public extension LinkFormation where Self: LinkBee {
    public var left: XAxisLinkBee<Self> {
        return XAxisLinkBee(left: self, attribute: .left)
    }

    public var right: XAxisLinkBee<Self> {
        return XAxisLinkBee(left: self, attribute: .right)
    }

    public var top: YAxisLinkBee<Self> {
        return YAxisLinkBee(left: self, attribute: .top)
    }

    public var bottom: YAxisLinkBee<Self> {
        return YAxisLinkBee(left: self, attribute: .bottom)
    }

    public var leading: XAxisLinkBee<Self> {
        return XAxisLinkBee(left: self, attribute: .leading)
    }

    public var trailing: XAxisLinkBee<Self> {
        return XAxisLinkBee(left: self, attribute: .trailing)
    }

    public var width: DimensionLinkBee<Self> {
        return DimensionLinkBee(left: self, attribute: .width)
    }

    public var height: DimensionLinkBee<Self> {
        return DimensionLinkBee(left: self, attribute: .height)
    }

    public var centerX: XAxisLinkBee<Self> {
        return XAxisLinkBee(left: self, attribute: .centerX)
    }

    public var centerY: YAxisLinkBee<Self> {
        return YAxisLinkBee(left: self, attribute: .centerY)
    }

    public var lastBaseline: YAxisLinkBee<Self> {
        return YAxisLinkBee(left: self, attribute: .lastBaseline)
    }

    public var firstBaseline: YAxisLinkBee<Self> {
        return YAxisLinkBee(left: self, attribute: .firstBaseline)
    }
}

public extension QueenBee {
    public var left: XAxisLinkBee<QueenBee> {
        return XAxisLinkBee(left: self, attribute: .left)
    }

    public var right: XAxisLinkBee<QueenBee> {
        return XAxisLinkBee(left: self, attribute: .right)
    }

    public var top: YAxisLinkBee<QueenBee> {
        return YAxisLinkBee(left: self, attribute: .top)
    }

    public var bottom: YAxisLinkBee<QueenBee> {
        return YAxisLinkBee(left: self, attribute: .bottom)
    }

    public var leading: XAxisLinkBee<QueenBee> {
        return XAxisLinkBee(left: self, attribute: .leading)
    }

    public var trailing: XAxisLinkBee<QueenBee> {
        return XAxisLinkBee(left: self, attribute: .trailing)
    }

    public var width: DimensionLinkBee<QueenBee> {
        return DimensionLinkBee(left: self, attribute: .width)
    }

    public var height: DimensionLinkBee<QueenBee> {
        return DimensionLinkBee(left: self, attribute: .height)
    }

    public var centerX: XAxisLinkBee<QueenBee> {
        return XAxisLinkBee(left: self, attribute: .centerX)
    }

    public var centerY: YAxisLinkBee<QueenBee> {
        return YAxisLinkBee(left: self, attribute: .centerY)
    }

    public var lastBaseline: YAxisLinkBee<QueenBee> {
        return YAxisLinkBee(left: self, attribute: .lastBaseline)
    }

    public var firstBaseline: YAxisLinkBee<QueenBee> {
        return YAxisLinkBee(left: self, attribute: .firstBaseline)
    }
}
