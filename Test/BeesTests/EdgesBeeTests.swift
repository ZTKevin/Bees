//
//  EdgesBeeTests.swift
//  Bees
//
//  Created by hongcaiyu on 2/2/18.
//  Copyright © 2018年 Lion. All rights reserved.
//

import XCTest
import Bees

class EdgesBeeTests: XCTestCase {
    
    let superview = View()
    
    override func setUp() {
        super.setUp()
        superview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEdges() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.edges == superview.bee.edges
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame == superview.frame, "EdgesBeeTests.testEdges failed")
    }
    
    func testEdgesInsert() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.edges == superview.bee.edges.inset(top: 10, left: 20, bottom: 30, right: 40)
        
        superview.layoutImmediately()
        
        var frame = superview.frame
        frame.origin = CGPoint(x: 20, y: 10)
        frame.size = CGSize(width: 1000 - 60, height: 1000 - 40)

        XCTAssert(view.frame == frame, "EdgesBeeTests.testEdgesInsert failed")
    }
    
}
