# 提供NSFoundataion基础功能

#### NSObjcet

1. NSObject+Swizzle ，提供了hook相关的功能
2. NSObject+MDUtility ，提供了实例自释放的方法

#### NSString （分类收敛于NSString+Momo.h/m文件中）

1. NSString+MFCateory ， 提供字符串空值判断
2. NSString+URLEncoding ， 字符串URL编解码，判断是否是IP
3. NSString+GetTextSize ， 自动计算字符串宽高

#### NSArray、NSDictionary、NSSet

1. NSArray+MDUtility ， 提供数组的map、filter功能。
2. NSArray+MMSafe ， 数组的安全读取方法
3. NSDictionary+MMSafe ， 字典(实现协议的类都可以)的安全读取方法
4. NSDictionary+URLQueryComponents ， 将字典转换为URL Query格式字符串
5. NSMutableSet+MMSafe ， 集合的安全读取方法

#### NSData

1. NSData+MMConverString ， 将NSData的字节流转换为16进制字符串

#### NSDate

1. NSDate+MMFormat ， 日期和字符串互转
2. NSDate+Utilities ， 日期的各种常用方法

#### NSFileManager

1. NSFileManager+Paths ， 各种常用沙盒路径的封装

#### JSON

1. MDJSONHelper，JSON格式化相关方法
