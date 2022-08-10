# MMSUIBaseFoundation

Swift实现的一些`UI`层常用扩展和函数

提供 `UIView`、`UILabel`、`UIButton`、`UIColor`等常用视图控件的纯`Swift`扩展

## API

|       类名        |       功能         |
| ----------------- | --------------------------- |
|UIView             | Frame/Corner |
| UIAlertController | alertShow |
| ... | ... |

## TODO

- [ ] UIButton
- [ ] UIColor
- [ ] UILabel
- [ ] ...

## 贡献指南：

1. 向项目`master`申请`developer`权限，然后创建自己的分支或者`fork`项目到自己的`git`目录下
2. 修改代码，包括且不限于修改代码的格式，减少代码的异味和安全漏洞，添加单元测试用例
3. 提交`mr`: 需要写明做了什么修改，比如`fix xxxx`；提交的内容；影响到的范围；潜在问题说明，应该怎么处理；兼容性；测试结果
告知项目`master`进行`review`，代码合并；
4. 提`issue`：需要写明你的需求或者`bug`详情

## 代码规范：

1. 变量名与方法名需符合小驼峰，类名需符合大驼峰
2. 添加 `extension`时参考 `RxSwift`、`Kingfisher` 类似域名的形式，我们采用`mms` 作为我们的命名空间，避免与其他第三库的命名冲突（可以参考下`UIView+Frame`的写法）

#### 推荐的代码风格

![继承/协议冒号](https://s.momocdn.com/w/u/others/2020/12/21/1608538385887-colon.png)
![多参数函数](https://s.momocdn.com/w/u/others/2020/12/21/1608538385893-multiple_parameters.png)
![字面量语法初始化](https://s.momocdn.com/w/u/others/2020/12/21/1608538385887-array_dict.png)



## 安装：

```ruby
pod 'MMSUIBaseFoundation'
```

## 联系：

如有问题，请联系 @fu.xianchao 或者 进入群组讨论： 24497606


