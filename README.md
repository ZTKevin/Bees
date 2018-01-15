# Bees

<img src="/Assets/iOSDemo.gif" align="right" height="350px" hspace="0px" vspace="0px">

[![Platform](https://img.shields.io/cocoapods/p/Bees.svg?style=flat)](https://github.com/hongcaiyu/Bees)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Bees.svg)](https://github.com/hongcaiyu/Bees)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/language-swift4-orange.svg)](https://github.com/hongcaiyu/Bees)




Bees 是一个简单易用的自动布局库，复杂的布局只需要几句简单的代码就可以完成。


如：
```swift

view1.bee.size == CGSize(width: 111, height: 111)

view1.bee.center == superView.bee.center

view3.bee.right.bottom == superView.bee.right.bottom.sub(10)

...

```
## 目录

- [环境](#环境)
- [安装](#安装)
- [使用](#使用)
- [License](#license)

## 环境

- iOS 9.0+/tvOS 9.0+/macOS 10.11+
- Xcode 9.0+
- Swift 4.0+

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
创建约束
```swift
view1.bee.left == view2.bee.left //view1的左边等于view2的左边。
view1.bee.left >= view2.bee.left //view1的左边大于等于view2的左边。
view1.bee.width <= view2.bee.width //view1的宽度小于等于view2的宽度。
view1.bee.width == 100 //view1的宽度=100
```

同时创建多个约束
```swift
view1.bee.width.height == (100, 200) //view1的宽度=100,高度=200
view1.bee.left.top == view2.bee.left.top //view1的左边等于view2的左边，view1的上边等于view2的上边。
```

约束的调整
```swift
view1.bee.width == view2.bee.width.mul(2) //view1的宽度等于view2的宽度 * 2。
view1.bee.width.mul(2) == view2.bee.width //view1的宽度等于view2的宽度 / 2。
view1.bee.width == view2.bee.width.div(2) //view1的宽度等于view2的宽度 / 2。
view1.bee.width.div(2) == view2.bee.width //view1的宽度等于view2的宽度 * 2。

//类似的
view1.bee.width == view2.bee.width.add(100) //view1的宽度等于view2的宽度 + 100。
```
### 完整的使用文档在：[使用指南](https://github.com/hongcaiyu/Bees/wiki)


## License

Bees is released under the MIT license. See LICENSE for details.
