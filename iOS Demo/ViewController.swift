//
//  ViewController.swift
//  iOS Demo
//
//  Created by hongcaiyu on 24/11/17.
//  Copyright © 2017年 Lion. All rights reserved.
//

import UIKit
import Bees


class ViewController: UIViewController {

    private lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueView.width.height == [200,100]
        blueView.top.left == self.view.top.left
        
        orangeView.width.height == blueView.width.height
        orangeView.bottom.right == self.view.bottom.right
    }

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
    }

}

