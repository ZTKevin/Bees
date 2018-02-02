//
//  SizeBeeTests.swift
//  Bees
//
//  Created by hongcaiyu on 2/2/18.
//  Copyright © 2018年 Lion. All rights reserved.
//

import XCTest
import Bees

class SizeBeeTests: XCTestCase {
    
    let superview = View()
    
    override func setUp() {
        super.setUp()
        superview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSizeDimension() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.size == CGSize(width: 100, height: 200)
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame.size == CGSize(width: 100, height: 200), "SizeBeeTests.testSizeDimension failed")
    }
    
    func testSizeEqual() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.size == superview.bee.size
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame.size == superview.frame.size, "SizeBeeTests.testSizeEqual failed")
    }
    
    func testSizeMul() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.size == superview.bee.size.mul(2)
        
        superview.layoutImmediately()
        
        let size = CGSize(width: superview.frame.size.width * 2, height: superview.frame.size.height * 2)

        XCTAssert(view.frame.size == size, "SizeBeeTests.testSizeMul failed")
    }
    
    func testSizeAdd() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.size == superview.bee.size.add(10)
        
        superview.layoutImmediately()
        
        let size = CGSize(width: superview.frame.size.width + 10, height: superview.frame.size.height + 10)
        
        XCTAssert(view.frame.size == size, "SizeBeeTests.testSizeAdd failed")
    }
    
}
