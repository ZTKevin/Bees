//
//  LayoutMaker.swift
//  Bees
//
//  Created by CY H on 2019/11/12.
//
//  Copyright (c) 2019 Caiyu Hong <hongcaiyu@live.com>
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

import Foundation

public class LayoutMaker {
    private var layouts: ConstraintSet? = nil
    
    public func remake(@LayoutBuilder layoutMaker: () -> ConstraintSet) {
        layouts?.deactivate()
        layouts = layoutMaker()
    }
    
    public init() {}
}

public protocol LayoutMakerProvider {
    var defaultLayoutMaker: LayoutMaker { get }
}

private var defaultLayoutMakerKey: UInt8 = 0

public extension LayoutMakerProvider {

    var defaultLayoutMaker: LayoutMaker {
        if let maker = objc_getAssociatedObject(self, &defaultLayoutMakerKey) as? LayoutMaker {
            return maker
        } else {
            let maker = LayoutMaker()
            objc_setAssociatedObject(self, &defaultLayoutMakerKey, maker, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return maker
        }
    }
}

extension View: LayoutMakerProvider {}

#if os(macOS)
import AppKit
extension NSViewController: LayoutMakerProvider {}
extension NSWindowController: LayoutMakerProvider {}
#else
import UIKit
extension UIViewController: LayoutMakerProvider {}
#endif

@_functionBuilder public struct LayoutBuilder {
    
    private struct ConstraintSetContainer: ConstraintSet {
        
        private let cs: [ConstraintSet]
        
        public func activate() {
            cs.forEach { $0.activate() }
        }
        
        public func deactivate() {
            cs.forEach { $0.deactivate() }
        }
        
        init(_ cs: [ConstraintSet] = []) {
            self.cs = cs
        }
    }
    
    public static func buildBlock() -> ConstraintSet {
        return ConstraintSetContainer()
    }
    
    public static func buildBlock(_ c0: LinkConstraintSet) -> ConstraintSet {
        return c0
    }
    
    public static func buildBlock(_ cs: LinkConstraintSet...) -> ConstraintSet {
        return ConstraintSetContainer(cs)
    }
    
    public static func buildIf(_ c0: LinkConstraintSet?) -> ConstraintSet {
        return c0 ?? buildBlock()
    }
    
    public static func buildEither(first: LinkConstraintSet) -> ConstraintSet {
        return first
    }
    
    public static func buildEither(second: LinkConstraintSet) -> ConstraintSet {
        return second
    }
    
    public static func buildBlock(_ c0: ConstraintSet) -> ConstraintSet {
        return c0
    }
    
    public static func buildBlock(_ cs: ConstraintSet...) -> ConstraintSet {
        return ConstraintSetContainer(cs)
    }
    
    public static func buildIf(_ c0: ConstraintSet?) -> ConstraintSet {
        return c0 ?? buildBlock()
    }
    
    public static func buildEither(first: ConstraintSet) -> ConstraintSet {
        return first
    }
    
    public static func buildEither(second: ConstraintSet) -> ConstraintSet {
        return second
    }
}


