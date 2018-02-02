//
//  CenterBeeTests.swift
//  Bees
//
//  Created by hongcaiyu on 2/2/18.
//  Copyright © 2018年 Lion. All rights reserved.
//

import XCTest
import Bees

class CenterBeeTests: XCTestCase {
    
    let superview = View()
    
    override func setUp() {
        super.setUp()
        superview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCenter() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.center == superview.bee.center
        view.bee.size == superview.bee.size
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame == superview.frame, "CenterBeeTests.testCenter failed")
    }
    
    func testCenterOffset() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.center == superview.bee.center.offset(horizontal: 10, vertical: 30)
        view.bee.size == superview.bee.size
        
        superview.layoutImmediately()
        
        let origin: CGPoint
        
        #if os(macOS)
            origin = CGPoint(x: 10, y: -30)
        #else
            origin = CGPoint(x: 10, y: 30)
        #endif
        
        XCTAssert(view.frame.origin == origin, "CenterBeeTests.testCenterOffset failed")
    }
    
    #if !os(macOS)
    func testCenterUIOffset() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.center == superview.bee.center.offset(UIOffset(horizontal: 10, vertical: 30))
        view.bee.size == superview.bee.size
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame.origin == CGPoint(x: 10, y: 30), "CenterBeeTests.testCenterUIOffset failed")
    }
    #endif
}
