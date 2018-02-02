//
//  LinkBeeTests.swift
//  BeesTests
//
//  Created by hongcaiyu on 1/2/18.
//  Copyright © 2018年 Lion. All rights reserved.
//

import XCTest
import Bees

class LinkBeeTests: XCTestCase {
    
    let superview = UIView()
    
    
    override func setUp() {
        super.setUp()
        superview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let view1 = UIView()
  
        superview.addSubview(view1)
        
        view1.bee.top.right.bottom.left == superview.bee.top.right.bottom.left
        superview.layoutIfNeeded()
        
        XCTAssert(superview.frame == view1.frame, "error")
        
    }
    
    
}
