//
//  View.swift
//  macOS Demo
//
//  Created by hongcaiyu on 5/12/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import Cocoa

class View: NSView {
    
    @IBInspectable var backgroundColor: NSColor? {
        didSet{
            self.needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if let backgroundColor = self.backgroundColor {
            backgroundColor.setFill()
            dirtyRect.fill()
        }
        super.draw(dirtyRect)
    }

}
