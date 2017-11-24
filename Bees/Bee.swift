//
//  Bee.swift
//  Bees
//
//  Created by hongcaiyu on 24/11/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import UIKit

public class Bee {
    let target: Any
    private var storagePollens = [Pollen]()
    
    init(target: Any) {
        self.target = target
    }
    
    func append(pollen: Pollen) {
        self.storagePollens.append(pollen)
    }
    
    var pollens: [Pollen] {
        return self.storagePollens
    }
    
    var pollensCount: Int {
        return self.storagePollens.count
    }
    
}

class Pollen {
    let attribute : NSLayoutAttribute
    
    var multiplier: CGFloat = 1
    
    var constant: CGFloat = 0
    
    init(attribute : NSLayoutAttribute) {
        self.attribute = attribute
    }
}

public extension UIView {
    public var top: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .top))
        return bee
    }
    
    public var bottom: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .bottom))
        return bee
    }
    
    public var left: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .left))
        return bee
    }
    
    public var right: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .right))
        return bee
    }
    
    public var width: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .width))
        return bee
    }
    
    public var height: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .height))
        return bee
    }
    
    public var leading: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .leading))
        return bee
    }
    
    public var trailing: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .trailing))
        return bee
    }
    
    public var centerX: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .centerX))
        return bee
    }
    
    public var centerY: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .centerY))
        return bee
    }
    
    public var lastBaseline: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .lastBaseline))
        return bee
    }
}

extension Bee {
    public var top: Bee {
        self.append(pollen: Pollen(attribute: .top))
        return self
    }
    
    public var bottom: Bee {
        self.append(pollen: Pollen(attribute: .bottom))
        return self
    }
    
    public var left: Bee {
        self.append(pollen: Pollen(attribute: .left))
        return self
    }
    
    public var right: Bee {
        self.append(pollen: Pollen(attribute: .right))
        return self
    }
    
    public var width: Bee {
        self.append(pollen: Pollen(attribute: .width))
        return self
    }
    
    public var height: Bee {
        self.append(pollen: Pollen(attribute: .height))
        return self
    }
    
    public var leading: Bee {
        self.append(pollen: Pollen(attribute: .leading))
        return self
    }
    
    public var trailing: Bee {
        self.append(pollen: Pollen(attribute: .trailing))
        return self
    }
    
    public var centerX: Bee {
        self.append(pollen: Pollen(attribute: .centerX))
        return self
    }
    
    public var centerY: Bee {
        self.append(pollen: Pollen(attribute: .centerY))
        return self
    }
    
    public var lastBaseline: Bee {
        self.append(pollen: Pollen(attribute: .lastBaseline))
        return self
    }
}

public extension UIView {
    public var firstBaseline: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .firstBaseline))
        return bee
    }
    
    public var leftMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .leftMargin))
        return bee
    }
    
    public var rightMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .rightMargin))
        return bee
    }
    
    public var topMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .topMargin))
        return bee
    }
    
    public var bottomMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .bottomMargin))
        return bee
    }
    
    public var leadingMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .leadingMargin))
        return bee
    }
    
    public var trailingMargin: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .trailingMargin))
        return bee
    }
    
    public var centerXWithinMargins: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .centerXWithinMargins))
        return bee
    }
    
    public var centerYWithinMargins: Bee {
        let bee = Bee(target: self)
        bee.append(pollen: Pollen(attribute: .centerYWithinMargins))
        return bee
    }
}

public extension Bee {
    public var firstBaseline: Bee {
        self.append(pollen: Pollen(attribute: .firstBaseline))
        return self
    }
    
    public var leftMargin: Bee {
        self.append(pollen: Pollen(attribute: .leftMargin))
        return self
    }
    
    public var rightMargin: Bee {
        self.append(pollen: Pollen(attribute: .rightMargin))
        return self
    }
    
    public var topMargin: Bee {
        self.append(pollen: Pollen(attribute: .topMargin))
        return self
    }
    
    public var bottomMargin: Bee {
        self.append(pollen: Pollen(attribute: .bottomMargin))
        return self
    }
    
    public var leadingMargin: Bee {
        self.append(pollen: Pollen(attribute: .leadingMargin))
        return self
    }
    
    public var trailingMargin: Bee {
        self.append(pollen: Pollen(attribute: .trailingMargin))
        return self
    }
    
    public var centerXWithinMargins: Bee {
        self.append(pollen: Pollen(attribute: .centerXWithinMargins))
        return self
    }
    
    public var centerYWithinMargins: Bee {
        self.append(pollen: Pollen(attribute: .centerYWithinMargins))
        return self
    }
}
