//
//  Pollen.swift
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

public class Pollen {
    let attribute : LayoutAttribute
    
    let bee: QueenBee
    
    private var multiplier: CGFloat = 1
    
    private var constant: CGFloat = 0
    
    private var priority: LayoutPriority? = nil
    
    init(attribute: LayoutAttribute, bee: QueenBee) {
        self.attribute = attribute
        self.bee = bee
    }
    
    func multiplier(_ multiplier: CGFloat = 1) {
        self.multiplier = multiplier
    }
    
    func constant(_ constant: CGFloat = 0) {
        self.constant = constant
    }
    
    func add(_ constant: CGFloat) {
        self.constant += constant
    }
    
    func sub(_ constant: CGFloat) {
        self.constant -= constant
    }
    
    func mul(_ multiplier: CGFloat) {
        self.constant *= multiplier
        self.multiplier *= multiplier
    }
    
    func div(_ divisor: CGFloat) {
        self.constant /= divisor
        self.multiplier /= divisor
    }
    
    func prioritize(_ priority: LayoutPriority) {
        self.priority = priority
    }
    
    static func makeConstraint(lhs: Pollen, rhs: Pollen, relation: LayoutRelation) -> LayoutConstraint {
        (lhs.bee.target as? View)?.translatesAutoresizingMaskIntoConstraints = false
        let multiplier = rhs.multiplier / lhs.multiplier
        let constant = rhs.constant - lhs.constant
        
        let layoutConstraint = LayoutConstraint(item: lhs.bee.target,
                                                attribute: lhs.attribute,
                                                relatedBy: relation,
                                                toItem: rhs.bee.target,
                                                attribute: rhs.attribute,
                                                multiplier: multiplier,
                                                constant: constant)
        if let priority = lhs.priority {
            layoutConstraint.priority = priority
        } else if let priority = rhs.priority {
            layoutConstraint.priority = priority
        }
        layoutConstraint.isActive = true
        return layoutConstraint
    }
    
    
    static func makeConstraint(lhs: Pollen, rhs: CGFloat, relation: LayoutRelation) -> LayoutConstraint {
        (lhs.bee.target as? View)?.translatesAutoresizingMaskIntoConstraints = false
        let multiplier = 1 / lhs.multiplier
        let constant = rhs - lhs.constant
        
        let layoutConstraint = LayoutConstraint(item: lhs.bee.target,
                                                attribute: lhs.attribute,
                                                relatedBy: relation,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: multiplier,
                                                constant: constant)
        if let priority = lhs.priority {
            layoutConstraint.priority = priority
        }
        layoutConstraint.isActive = true
        return layoutConstraint
    }
}
