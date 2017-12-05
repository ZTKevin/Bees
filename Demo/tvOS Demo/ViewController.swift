//
//  ViewController.swift
//  tvOS Demo
//
//  Created by hongcaiyu on 5/12/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import UIKit
import Bees

class ViewController: UIViewController {

    @IBOutlet var superView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var leftTopView: UIView!
    @IBOutlet weak var rightTopView: UIView!
    @IBOutlet weak var leftBottomView: UIView!
    @IBOutlet weak var rightBottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sizeConstraints = centerView.bee.size == CGSize(width: 300, height: 300)
        let pointConstraints = centerView.bee.center == superView.bee.center
        
        let centerViewXOffsetConstraint = pointConstraints[0]
        let centerViewYOffsetConstraint = pointConstraints[1]
        
        let centerViewWidthConstraint = sizeConstraints[0]
        let centerViewHeightConstraint = sizeConstraints[1]
        
        leftTopView.bee.left.top == superView.bee.left.top + 10
        leftTopView.bee.right == centerView.bee.left - 10
        leftTopView.bee.bottom == centerView.bee.bottom
        
        rightTopView.bee.top.right == superView.bee.top.add(10).right.sub(10)
        rightTopView.bee.bottom == centerView.bee.top - 10
        rightTopView.bee.left == centerView.bee.left
        
        leftBottomView.bee.left.bottom == superView.bee.left.add(10).bottom.sub(10)
        leftBottomView.bee.top == centerView.bee.bottom + 10
        leftBottomView.bee.right == centerView.bee.right
        
        rightBottomView.bee.right.bottom == superView.bee.right.bottom - 10
        rightBottomView.bee.left == centerView.bee.right + 10
        rightBottomView.bee.top == centerView.bee.top
        
        superView.layoutIfNeeded()
        
        
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = 100
                centerViewYOffsetConstraint.constant = -100
                centerViewHeightConstraint.constant = 210
                centerViewWidthConstraint.constant = 270
                self.superView.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = 100
                centerViewYOffsetConstraint.constant = 100
                centerViewHeightConstraint.constant = 360
                centerViewWidthConstraint.constant = 210
                self.superView.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = -100
                centerViewYOffsetConstraint.constant = 100
                centerViewHeightConstraint.constant = 240
                centerViewWidthConstraint.constant = 330
                self.superView.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = -100
                centerViewYOffsetConstraint.constant = -100
                centerViewHeightConstraint.constant = 120
                centerViewWidthConstraint.constant = 300
                self.superView.layoutIfNeeded()
            }
            
        }, completion: nil)
    }
    
}

