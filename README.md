# Bees

<img src="/Assets/iOSDemo.gif" align="right" height="350px" hspace="0px" vspace="0px">

[![Build Status](https://travis-ci.org/hongcaiyu/Bees.svg)](https://travis-ci.org/hongcaiyu/Bees)
[![Platform](https://img.shields.io/cocoapods/p/Bees.svg?style=flat)](https://github.com/hongcaiyu/Bees)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Bees.svg)](https://github.com/hongcaiyu/Bees)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/hongcaiyu/Bees)




Bees 是一个对自带布局约束API(NSLayoutConstraint)的的一个封装，使之可以更加方便的创建约束。


如：
```swift

view0.bee.size == CGSize(width: 111, height: 111)

view1.bee.center == superView.bee.center

view2.bee.right.bottom == superView.bee.right.bottom.sub(10)

view3.bee.edges == superView.bee.edges.inset(10)

...

```
## 目录

- [环境](#环境)
- [安装](#安装)
- [使用](#使用)
- [License](#license)

## 环境

- iOS 8.0+/tvOS 9.0+/macOS 10.10+
- Xcode 11.1+
- Swift 5.1

## 安装

### [CocoaPods](http://cocoapods.org)

```ruby
  pod 'Bees'
```


### [Carthage](https://github.com/Carthage/Carthage)


```ruby
  github "hongcaiyu/Bees"
```




## 使用
### 快速上手

```swift
import UIKit
import Bees

class ViewController: UIViewController {
    
    lazy var redView = UIView()
    lazy var blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(redView)
        self.view.addSubview(blueView)
        
        redView.bee.edges == self.view.bee.edges.inset(top: 10, bottom: 10)
        blueView.bee.size == redView.bee.size.mul(0.5)
        blueView.bee.left.top == redView.bee.left.add(10).top.add(10)
        
    }

}

```

### [使用文档](https://github.com/hongcaiyu/Bees/wiki/使用文档)


## License

Bees is released under the MIT license. See LICENSE for details.
