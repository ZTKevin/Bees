//
//  LayoutMakerTest.swift
//  BeesTests
//
//  Created by CY H on 2019/11/12.
//  Copyright © 2019 Lion. All rights reserved.
//

import XCTest
import Bees

class LayoutMakerTest: XCTestCase {

    let superview = View()
    
    let layoutMaker = LayoutMaker()
    
    
    override func setUp() {
        super.setUp()
        superview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRemake() {
        let view = View()
        
        superview.addSubview(view)
        
        layoutMaker.remake {
            #if os(macOS)
                view.bee.bottom.left == superview.bee.bottom.left
                view.bee.size == CGSize(width: 200, height: 200)
            #else
                view.bee.top.left == superview.bee.top.left
                view.bee.size == CGSize(width: 200, height: 200)
            #endif
        }
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame == CGRect(x: 0, y: 0, width: 200, height: 200), "LayoutMakerTest.testRemake failed")
        
        layoutMaker.remake {
            #if os(macOS)
                view.bee.bottom.left == superview.bee.bottom.left
                view.bee.size == CGSize(width: 300, height: 300)
            #else
                view.bee.top.left == superview.bee.top.left
                view.bee.size == CGSize(width: 300, height: 300)
            #endif
        }
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame == CGRect(x: 0, y: 0, width: 300, height: 300), "LayoutMakerTest.testRemake failed")
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
