//
//  Bee.swift
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

import UIKit

public class Bee {
    let target: Any
    private var storagePollens = [Pollen]()
    
    init(target: Any) {
        self.target = target
    }
    
    func append(pollen: Pollen) -> Bee {
        self.storagePollens.append(pollen)
        return self
    }
    
    var pollens: [Pollen] {
        return self.storagePollens
    }
    
    var pollensCount: Int {
        return self.storagePollens.count
    }
    
    var lastPollen: Pollen {
        return self.storagePollens.last!
    }
    
    
    public func add(_ constant: CGFloat) -> Bee {
        self.storagePollens.last?.constant += constant
        return self
    }
    
    public func sub(_ constant: CGFloat) -> Bee {
        self.storagePollens.last?.constant -= constant
        return self
    }
    
    public func mul(_ multiplier: CGFloat) -> Bee {
        self.storagePollens.last?.constant *= multiplier
        self.storagePollens.last?.multiplier *= multiplier
        return self
    }
    
    public func div(_ divisor: CGFloat) -> Bee {
        self.storagePollens.last?.constant /= divisor
        self.storagePollens.last?.multiplier /= divisor
        return self
    }
    
    public func prioritize(_ priority: UILayoutPriority) -> Bee {
        self.storagePollens.last?.priority = priority
        return self
    }
    
    public func prioritize(_ priority: Float) -> Bee {
        return self.prioritize(UILayoutPriority(rawValue: priority))
    }
    
}

class Pollen {
    let attribute : NSLayoutAttribute
    
    var multiplier: CGFloat = 1
    
    var constant: CGFloat = 0
    
    var priority: UILayoutPriority? = nil

    init(attribute : NSLayoutAttribute) {
        self.attribute = attribute
    }
}

public extension UIView {
    public var bee: Bee {
        return Bee(target: self)
    }
}

public extension Bee {
    public var top: Bee {
        return self.append(pollen: Pollen(attribute: .top))
    }
    
    public var bottom: Bee {
        return self.append(pollen: Pollen(attribute: .bottom))
    }
    
    public var left: Bee {
        return self.append(pollen: Pollen(attribute: .left))
    }
    
    public var right: Bee {
        return self.append(pollen: Pollen(attribute: .right))
    }
    
    public var width: Bee {
        return self.append(pollen: Pollen(attribute: .width))
    }
    
    public var height: Bee {
        return self.append(pollen: Pollen(attribute: .height))
    }
    
    public var leading: Bee {
        return self.append(pollen: Pollen(attribute: .leading))
    }
    
    public var trailing: Bee {
        return self.append(pollen: Pollen(attribute: .trailing))
    }
    
    public var centerX: Bee {
        return self.append(pollen: Pollen(attribute: .centerX))
    }
    
    public var centerY: Bee {
        return self.append(pollen: Pollen(attribute: .centerY))
    }
    
    public var lastBaseline: Bee {
        return self.append(pollen: Pollen(attribute: .lastBaseline))
    }
    
    
    
    @available(iOS 8.0, *)
    public var firstBaseline: Bee {
        return self.append(pollen: Pollen(attribute: .firstBaseline))
    }
    
    @available(iOS 8.0, *)
    public var leftMargin: Bee {
        return self.append(pollen: Pollen(attribute: .leftMargin))
    }
    
    @available(iOS 8.0, *)
    public var rightMargin: Bee {
        return self.append(pollen: Pollen(attribute: .rightMargin))
    }
    
    @available(iOS 8.0, *)
    public var topMargin: Bee {
        return self.append(pollen: Pollen(attribute: .topMargin))
    }
    
    @available(iOS 8.0, *)
    public var bottomMargin: Bee {
        return self.append(pollen: Pollen(attribute: .bottomMargin))
    }
    
    @available(iOS 8.0, *)
    public var leadingMargin: Bee {
        return self.append(pollen: Pollen(attribute: .leadingMargin))
    }
    
    @available(iOS 8.0, *)
    public var trailingMargin: Bee {
        return self.append(pollen: Pollen(attribute: .trailingMargin))
    }
    
    @available(iOS 8.0, *)
    public var centerXWithinMargins: Bee {
        return self.append(pollen: Pollen(attribute: .centerXWithinMargins))
    }
    
    @available(iOS 8.0, *)
    public var centerYWithinMargins: Bee {
        return self.append(pollen: Pollen(attribute: .centerYWithinMargins))
    }
}

