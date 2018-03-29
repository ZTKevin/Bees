//
//  LinkBee.swift
//  Bees
//
//  Created by hongcaiyu on 11/1/18.
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
#else
    import UIKit
#endif

public struct LinkConstraintSet: ConstraintSet {

    private var constraints = [LayoutConstraint]()

    fileprivate mutating func append(_ constraint: LayoutConstraint) {
        self.constraints.append(constraint)
    }
    
    private func constraintAt(index: Int) -> LayoutConstraint? {
        if constraints.count > index {
            return constraints[index]
        }
        return nil
    }
    
    public func activate() {
        LayoutConstraint.activate(constraints)
    }
    
    public func deactivate() {
        LayoutConstraint.deactivate(constraints)
    }
    
    public subscript(index: Int) -> LayoutConstraint {
        return constraints[index]
    }
    
    public var count: Int {
        return constraints.count
    }
    
    public var first: LayoutConstraint? {
        return constraintAt(index: 0)
    }
    
    public var second: LayoutConstraint? {
        return constraintAt(index: 1)
    }

    public var third: LayoutConstraint? {
        return constraintAt(index: 2)
    }
    
    public var fourth: LayoutConstraint? {
        return constraintAt(index: 3)
    }

}

public class LinkBee {
    let leftBee: LinkBee?
    let pollen: Pollen
    
    init(left: QueenBee, attribute: LayoutAttribute) {
        self.leftBee = nil
        self.pollen = Pollen(attribute: attribute, bee: left)
    }
    
    init(left: LinkBee, attribute: LayoutAttribute) {
        self.leftBee = left
        self.pollen = Pollen(attribute: attribute, bee: left.pollen.bee)
    }
}

public extension Formation where Self: LinkBee, ConstraintsType == LinkConstraintSet {
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
    public static func makeConstraints(lhs: Self, rhs: Self, relation: LayoutRelation) -> LinkConstraintSet {
        var constraints = LinkConstraintSet()
        func makeConstraints(lhs: LinkBee, rhs: LinkBee) {
            if let left = lhs.leftBee, let right = rhs.leftBee {
                makeConstraints(lhs: left, rhs: right)
            }
            let constraint = Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs.pollen, relation: relation)
            constraints.append(constraint)
        }
        
        makeConstraints(lhs: lhs, rhs: rhs)
        return constraints
    }
    
    public static func prioritize(lhs: Self, rhs: LayoutPriority) {
        var bee: LinkBee? = lhs
        while let linkBee = bee {
            linkBee.pollen.prioritize(rhs)
            bee = linkBee.leftBee
        }
    }
}


public class YAxisLinkBee<Left>: LinkBee, Formation {
    public typealias ConstraintsType = LinkConstraintSet
}

public class XAxisLinkBee<Left>: LinkBee, Formation {
    public typealias ConstraintsType = LinkConstraintSet
}

public class DimensionLinkBee<Left>: LinkBee, Formation {
    public typealias ConstraintsType = LinkConstraintSet
}

private func makeConstraints(lhs: DimensionLinkBee<QueenBee>, rhs: CGFloat, relation: LayoutRelation) -> LinkConstraintSet {
    var constraints = LinkConstraintSet()
    constraints.append(Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs, relation: relation))
    return constraints
}

private func makeConstraints(lhs: DimensionLinkBee<DimensionLinkBee<QueenBee>>, rhs: (CGFloat, CGFloat), relation: LayoutRelation) -> LinkConstraintSet {
    var constraints = LinkConstraintSet()
    constraints.append(Pollen.makeConstraint(lhs: lhs.leftBee!.pollen, rhs: rhs.0, relation: relation))
    constraints.append(Pollen.makeConstraint(lhs: lhs.pollen, rhs: rhs.1, relation: relation))
    return constraints
}

@discardableResult
public func ==(lhs: DimensionLinkBee<QueenBee>, rhs: CGFloat) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .equal)
}

@discardableResult
public func >=(lhs: DimensionLinkBee<QueenBee>, rhs: CGFloat) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
}

@discardableResult
public func <=(lhs: DimensionLinkBee<QueenBee>, rhs: CGFloat) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
}

@discardableResult
public func ==(lhs: DimensionLinkBee<DimensionLinkBee<QueenBee>>, rhs: (CGFloat, CGFloat)) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .equal)
}

@discardableResult
public func >=(lhs: DimensionLinkBee<DimensionLinkBee<QueenBee>>, rhs: (CGFloat, CGFloat)) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqual)
}

@discardableResult
public func <=(lhs: DimensionLinkBee<DimensionLinkBee<QueenBee>>, rhs: (CGFloat, CGFloat)) -> LinkConstraintSet {
    return makeConstraints(lhs: lhs, rhs: rhs, relation: .lessThanOrEqual)
}

public extension Formation where Self: LinkBee {
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

#if !os(macOS)
    public extension Formation where Self: LinkBee {
        public var leftMargin: XAxisLinkBee<Self> {
            return XAxisLinkBee(left: self, attribute: .leftMargin)
        }
        
        public var rightMargin: XAxisLinkBee<Self> {
            return XAxisLinkBee(left: self, attribute: .rightMargin)
        }
        
        public var topMargin: YAxisLinkBee<Self> {
            return YAxisLinkBee(left: self, attribute: .topMargin)
        }
        
        public var bottomMargin: YAxisLinkBee<Self> {
            return YAxisLinkBee(left: self, attribute: .bottomMargin)
        }
        
        public var leadingMargin: XAxisLinkBee<Self> {
            return XAxisLinkBee(left: self, attribute: .leadingMargin)
        }
        
        public var trailingMargin: XAxisLinkBee<Self> {
            return XAxisLinkBee(left: self, attribute: .trailingMargin)
        }
        
        public var centerXWithinMargins: XAxisLinkBee<Self> {
            return XAxisLinkBee(left: self, attribute: .centerXWithinMargins)
        }
        
        public var centerYWithinMargins: YAxisLinkBee<Self> {
            return YAxisLinkBee(left: self, attribute: .centerYWithinMargins)
        }
    }
    
    public extension QueenBee {
        public var leftMargin: XAxisLinkBee<QueenBee> {
            return XAxisLinkBee(left: self, attribute: .leftMargin)
        }
        
        public var rightMargin: XAxisLinkBee<QueenBee> {
            return XAxisLinkBee(left: self, attribute: .rightMargin)
        }
        
        public var topMargin: YAxisLinkBee<QueenBee> {
            return YAxisLinkBee(left: self, attribute: .topMargin)
        }
        
        public var bottomMargin: YAxisLinkBee<QueenBee> {
            return YAxisLinkBee(left: self, attribute: .bottomMargin)
        }
        
        public var leadingMargin: XAxisLinkBee<QueenBee> {
            return XAxisLinkBee(left: self, attribute: .leadingMargin)
        }
        
        public var trailingMargin: XAxisLinkBee<QueenBee> {
            return XAxisLinkBee(left: self, attribute: .trailingMargin)
        }
        
        public var centerXWithinMargins: XAxisLinkBee<QueenBee> {
            return XAxisLinkBee(left: self, attribute: .centerXWithinMargins)
        }
        
        public var centerYWithinMargins: YAxisLinkBee<QueenBee> {
            return YAxisLinkBee(left: self, attribute: .centerYWithinMargins)
        }
    }
#endif
