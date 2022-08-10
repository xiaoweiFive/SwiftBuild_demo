//
//  MMSScrollLabelClassFunc.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

extension MMSScrollLabel {
    
    class fileprivate func notifyController(_ controller: UIViewController, message: NotificationKey) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: message.rawValue), object: nil, userInfo: ["controller" : controller])
    }
    
    /// 重新启动 UIViewController 具有指定视图控制器 ScrollLabel 实例的便捷方法
    /// - Parameter controller: UIViewController
    public class func restartLabelsOfController(_ controller: UIViewController) {
        notifyController(controller, message: .restart)
    }
    
    /// 用于标记 UIViewController 中 ScrollLabel 实例, 已标识的 labelize = true
    /// - Parameter controller: UIViewController
    public class func controllerLabelsLabelize(_ controller: UIViewController) {
        notifyController(controller, message: .labelize)
    }
    
    /// 取消标记 UIViewController 中 ScrollLabel 实例, 已标识的 labelize = false
    /// - Parameter controller: UIViewController
    public class func controllerLabelsAnimate(_ controller: UIViewController) {
        notifyController(controller, message: .animate)
    }
}
