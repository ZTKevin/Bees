//
//  ViewController.swift
//  macOS Demo
//
//  Created by hongcaiyu on 5/12/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import Cocoa
import Bees

class ViewController: NSViewController {
    
    @IBOutlet var superView: NSView!
    @IBOutlet weak var centerView: NSView!
    
    @IBOutlet weak var leftTopView: NSView!
    @IBOutlet weak var rightTopView: NSView!
    @IBOutlet weak var leftBottomView: NSView!
    @IBOutlet weak var rightBottomView: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()

        centerView.bee.size == CGSize(width: 111, height: 111)
        centerView.bee.center == superView.bee.center

        leftTopView.bee.left.top == superView.bee.left.add(10).top.add(10)
        leftTopView.bee.right == centerView.bee.left.sub(10)
        leftTopView.bee.bottom == centerView.bee.bottom
        
        rightTopView.bee.top.right == superView.bee.top.add(10).right.sub(10)
        rightTopView.bee.bottom == centerView.bee.top.sub(10)
        rightTopView.bee.left == centerView.bee.left
        
        leftBottomView.bee.left.bottom == superView.bee.left.add(10).bottom.sub(10)
        leftBottomView.bee.top == centerView.bee.bottom.add(10)
        leftBottomView.bee.right == centerView.bee.right
        
        rightBottomView.bee.right.bottom == superView.bee.right.sub(10).bottom.sub(10)
        rightBottomView.bee.left == centerView.bee.right.add(10)
        rightBottomView.bee.top == centerView.bee.top

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

