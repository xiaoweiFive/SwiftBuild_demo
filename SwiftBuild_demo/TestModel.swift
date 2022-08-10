//
//  TestModel.swift
//  SwiftBuild_demo
//
//  Created by zhangzhenwei on 2022/7/26.
//

import UIKit

@objc class TestModel: NSObject {
    var age: Int = 10

    
    func myname(_ name: String?, _ sex: Int?, age: Int = 0) {
        
        let label = UILabel(frame: CGRect(x: 10, y: 50, width: 100, height: 40))
        label.backgroundColor = UIColor.red
        label.text = "哈哈哈"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15)
        
        let type = ((sex == 1) ? "有性别": (name == nil ? "zhangsan" : "lisi"))
        let myAge = sex ?? 0
        let testAge = ((myAge+1) > 5) ? "大于5岁" : "小于5岁"
        print("=========type=\(testAge)")
    }
}
