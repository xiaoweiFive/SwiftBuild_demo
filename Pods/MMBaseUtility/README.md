# 常用工具类



## 待处理

1. 未使用的类清理
2. 细化为timer、safe容器、timer、WeakProxy、KeyChain、PHPhotoLibrary分类等库
3. 剔除MMUtility、相关方法分别迁移至NSNotification和UIApplication分类



#### MDLinkedMap

1. MDLinkedMap ，链表和字典的结合，可以理解为带顺序的字典

#### MDQueue、MDStack

1. MDQueue ， 队列及相应方法
2. MDKeyQuene ， 带key的队列
3. MDStack ， 栈及相应方法

#### MDWeakProxy

1. MDWeakProxy ， 弱引用的代理

#### MultipleThread ， 线程安全的数据集合 【
##### 废弃！！避免后续系统更新造成方法内部相互调用产生死锁】
##### 注：不要继承系统集合类，并对其相关方法进行加锁访问

1. MDSynchronizedSet 
2. MDThreadSafeDictionary
3. MDThreadSafeMapTable
4. MDThreadSafeSet
5. QMSafeMutableArray
6. QMSafeMutableDictionary

#### DispatchSource

1. DispatchSource ， 根据线程繁忙程度合并刷新 UI 和 数据

#### Timer

1. MDSourceTimer , gcd的定时器的封装
2. MFTimer ， 同MDSourceTimer ， 推荐使用 MDSourceTimer
3. NSTimer+MDBlockSupport ， 对NSTimer提供了block扩展
4. MDCountLimitTimer ， 意义不明
5. MDDisplayLinkProxy ， DisplayLink 的 target 弱引用

#### UIDevice

1. UIDevice-Hardware ， 提供设备相关信息及设备型号判断

#### KeyChain

1. UIMomoCKeyChainStore ， 提供钥匙链相关操作方法
