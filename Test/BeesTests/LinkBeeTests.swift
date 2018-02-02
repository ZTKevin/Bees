//
//  LinkBeeTests.swift
//  BeesTests
//
//  Created by hongcaiyu on 1/2/18.
//  Copyright © 2018年 Lion. All rights reserved.
//

import XCTest
import Bees

extension View {
    func layoutImmediately() {
        #if os(macOS)
            self.layoutSubtreeIfNeeded()
        #else
            self.layoutIfNeeded()
        #endif
    }
}



class LinkBeeTests: XCTestCase {
    
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
        
        view.bee.top.right.bottom.left == superview.bee.top.right.bottom.left
        superview.layoutImmediately()
        
        XCTAssert(superview.frame == view.frame, "LinkBeeTests.testEdges failed")
    }
    
    func testSizeDimension() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.width.height == (100,200)

        superview.layoutImmediately()
        
        XCTAssert(view.frame.size == CGSize(width: 100, height: 200), "LinkBeeTests.testSizeDimension failed")
    }
    
    func testSizeEqual() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.left.top == superview.bee.left.top
        view.bee.width.height == superview.bee.width.height
        
        superview.layoutImmediately()
        
        XCTAssert(view.frame.size == superview.frame.size, "LinkBeeTests.testSizeEqual failed")
    }
    
    func testEdgesAdjust() {
        let view = View()
        
        superview.addSubview(view)
        
        view.bee.top.right.bottom.left == superview.bee.top.add(100).right.sub(100).bottom.sub(100).left.add(100)
        superview.layoutImmediately()
        
        XCTAssert(CGRect(x: 100, y: 100, width: 800, height: 800) == view.frame, "LinkBeeTests.testEdgesAdjust failed")
    }
    
    
    
    
}
