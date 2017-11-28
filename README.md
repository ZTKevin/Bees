# Bees



[![Platform](https://img.shields.io/cocoapods/p/Bees.svg?style=flat)](https://github.com/hongcaiyu/Bees)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Bees.svg)](https://github.com/hongcaiyu/Bees)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/language-swift4-orange.svg)](https://github.com/hongcaiyu/Bees)

Bees 是一个简单易用的自动布局库，复杂的布局只需要几句简单的代码就可以完成。

<img src="/Assets/iOSDemo.gif" align="right" height="400px" hspace="0px" vspace="20px">

比如：
```swift

centerView.bee.size == CGSize(width: 111, height: 111)
centerView.bee.center == superView.bee.center

leftTopView.bee.left.top == superView.bee.left.top + 10
leftTopView.bee.right == centerView.bee.left - 10
leftTopView.bee.bottom == centerView.bee.bottom
        
rightTopView.bee.top.right == superView.bee.top.add(10).right.sub(10)
rightTopView.bee.bottom == centerView.bee.top - 10
rightTopView.bee.left == centerView.bee.left
        
leftBottomView.bee.left.bottom == superView.bee.left.add(10).bottom.sub(10)
leftBottomView.bee.top == centerView.bee.bottom + 10
leftBottomView.bee.right == centerView.bee.right

rightBottomView.bee.right.bottom == superView.bee.right.bottom - 10
rightBottomView.bee.left == centerView.bee.right + 10
rightBottomView.bee.top == centerView.bee.top
```
## 目录

- [使用环境](#使用环境)
- [安装](#安装)
- [使用](#使用)
- [License](#license)

## 使用环境

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## 安装

### CocoaPods

如果没有安装[CocoaPods](http://cocoapods.org) ，可以使用以下命令安装。

```bash
$ gem install cocoapods
```
安装好CocoaPods后，在Podfile中添加：
```ruby
  pod 'Bees'
```
然后在项目根目录内执行以下命令
```bash
$ pod install
```

### 手动

如果你没有使用CocoaPods等包管理工具，就需要手动倒入Bees项目到自己的项目中。

## 使用
[使用指南](https://github.com/hongcaiyu/Bees/wiki)

## License

Bees is released under the MIT license. See LICENSE for details.
