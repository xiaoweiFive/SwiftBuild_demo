# MMSBaseFoundation

对`swift`语言中的基本数据类型进行封装扩展，提供包含但不限于 `Data`、`Dictionary`、`Array`、`String` 等数据类型的扩展函数。

目的是为使用`swift`语言开发业务的同学提供便利，提高开发效率，同时也避免了重复造轮子导致包大小增加的问题；

这是一个新生仓库，目前还处于开发完善阶段，后续的开发计划与进度会同步到 [计划&进度](https://moji.wemomo.com/doc#/mdetail/136608) 中；

## 贡献指南：

1. 向项目`master`申请`developer`权限，然后创建自己的分支或者`fork`项目到自己的`git`目录下
2. 修改代码，包括且不限于修改代码的格式，减少代码的异味和安全漏洞，添加单元测试用例
3. 提交`mr`：需要写明做了什么修改（比如`fix xxxx`）、影响范围、潜在问题说明、应该怎么处理、兼容性、测试结果等等。告知项目`master`进行`review`，代码合并；
4. 提`issue`：需要写明你的需求或者`bug`详情

## 代码规范：

1. 变量名与方法名需符合小驼峰，类名需符合大驼峰
2. 添加 `extension`时参考 `RxSwift`、`Kingfisher` 类似域名的形式，我们采用`mms` 作为我们的域名，避免与其他第三库的命名冲突

#### 推荐的代码风格

逗号（,）用在形参列表和元组/数组/字典字面量时，在逗号后面而不是前面。

```swift
// 推荐
let numbers = [1, 2, 3]


// 不推荐
let numbers = [1,2,3]
let numbers = [1 ,2 ,3]
let numbers = [1 , 2 , 3]
```

如果是下列场景，加在冒号（:）后面而不是前面

    父类/协议遵循列表和范型约束。

```swift
 //推荐
 struct HashTable: Collection {
   // ...
 }

 struct AnyEquatable<Wrapped: Equatable>: Equatable {
   // ...
 }

 //不推荐
 struct HashTable : Collection {
   // ...
 }

 struct AnyEquatable<Wrapped : Equatable> : Equatable {
   // ...
 }
```

函数实参标签和元组元素标签。

```swift
 //推荐
 let tuple: (x: Int, y: Int)

 func sum(_ numbers: [Int]) {
   // ...
 }

 //不推荐
 let tuple: (x:Int, y:Int)
 let tuple: (x : Int, y : Int)

 func sum(_ numbers:[Int]) {
   // ...
 }

 func sum(_ numbers : [Int]) {
   // ...
 }
```

变量/属性的类型显式声明。

```swift
  //推荐
  let number: Int = 5

  //不推荐
  let number:Int = 5
  let number : Int = 5
```

字典类型缩写

```swift
 //推荐
 var nameAgeMap: [String: Int] = [:]

 //不推荐
 var nameAgeMap: [String:Int] = [:]
 var nameAgeMap: [String : Int] = [:]
```

字典字面量

```swift
  //推荐
  let nameAgeMap = ["Ed": 40, "Timmy": 9]

  //不推荐
  let nameAgeMap = ["Ed":40, "Timmy":9]
  let nameAgeMap = ["Ed" : 40, "Timmy" : 9]

// 推荐
var names: [String] = []
var lookup: [String: Int] = [:]

//不推荐
var names = [String]()
var lookup = [String: Int]()
```

函数声明：

> 多参数需要换行

```swift
func reticulateSplines(spline: [Double]) -> Bool {
  // reticulate code goes here
}

func reticulateSplines(
  spline: [Double], 
  adjustmentFactor: Double,
  translateConstant: Int, 
  comment: String
) -> Bool {
  // reticulate code goes here
}
```

[继承/协议冒号](https://s.momocdn.com/w/u/others/2020/12/21/1608538385887-colon.png)
[多参数函数](https://s.momocdn.com/w/u/others/2020/12/21/1608538385893-multiple_parameters.png)
[字面量语法初始化](https://s.momocdn.com/w/u/others/2020/12/21/1608538385887-array_dict.png)

## 安装：

```ruby
pod 'MMSBaseFoundation'
```

## 版本记录：

[传送门](https://moji.wemomo.com/doc#/mdetail/136595)

## 计划

[最新计划版本](https://moji.wemomo.com/doc#/mdetail/137997)

#### copy版本

- [x] 把现有的 [MMSUtility](https://git.wemomo.com/ios/components/MDSUtility) 以及其他业务已有的通用`repo` 整合进来，组员`review`并长期补充	（@ji.linlin）
	> @ji.linlin 整合，其他人补充完善

	- Foundation Extention  
	- UI Extention  

- [ ] 图片加载：提供一个上层接口，内部实现采用SDWebImage / Kingfisher 各实现一份，方便切换 （@wang.kejie）

- [ ] 接入KakaModel，扩展一些现在用的比较多的或实用的方法（e.g merge）   （@ji.linlin）

- [ ] 网络请求：封装 [Alamofire](https://github.com/Alamofire/Alamofire)（会考虑借鉴 [Moya](https://github.com/Moya/Moya) 及其他开源库的设计） （@全员参与）

	- 接口设计（兼容OC现有的接口）

	- 参数处理（e.g 公参，加密）
  
	- 上传下载
  
	- 缓存


## 联系：

如有问题，请联系 @fu.xianchao 、@ji.linlin  或进入群组讨论： 24497606
