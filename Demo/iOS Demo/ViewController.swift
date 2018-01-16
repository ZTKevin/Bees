//
//  ViewController.swift
//  iOS Demo
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
import Bees


class ViewController: UIViewController {
    @IBOutlet var superView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var centerSubView: UIView!
    
    @IBOutlet weak var leftTopView: UIView!
    @IBOutlet weak var rightTopView: UIView!
    @IBOutlet weak var leftBottomView: UIView!
    @IBOutlet weak var rightBottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sizeConstraints = centerView.bee.size == CGSize(width: 111, height: 111)
        let pointConstraints = centerView.bee.center == superView.bee.center
        
        let centerViewXOffsetConstraint = pointConstraints.x
        let centerViewYOffsetConstraint = pointConstraints.y
        
        let centerViewWidthConstraint = sizeConstraints.width
        let centerViewHeightConstraint = sizeConstraints.height
        
        centerSubView.bee.edge == centerView.bee.edge.inset(top: 10, left: 10, bottom: 10, right: 10)
        

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
        
        superView.layoutIfNeeded()
        
        
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = 37
                centerViewYOffsetConstraint.constant = -37
                centerViewHeightConstraint.constant = 70
                centerViewWidthConstraint.constant = 90
                self.superView.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = 37
                centerViewYOffsetConstraint.constant = 37
                centerViewHeightConstraint.constant = 120
                centerViewWidthConstraint.constant = 70
                self.superView.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = -37
                centerViewYOffsetConstraint.constant = 37
                centerViewHeightConstraint.constant = 80
                centerViewWidthConstraint.constant = 110
                self.superView.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25){
                centerViewXOffsetConstraint.constant = -37
                centerViewYOffsetConstraint.constant = -37
                centerViewHeightConstraint.constant = 120
                centerViewWidthConstraint.constant = 100
                self.superView.layoutIfNeeded()
            }

        }, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

