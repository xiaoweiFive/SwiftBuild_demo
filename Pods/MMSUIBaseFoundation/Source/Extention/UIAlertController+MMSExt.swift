//
//  UIAlertController+MMSExtention.swift
//  MMSUIBaseFoundation
//
//  Created by Zero.D.Saber on 2020/12/2.
//

import UIKit
import ObjectiveC

private var MMSUIAlertActionKey: Void?

public struct MMSActionModel {
    let title: String
    let style: UIAlertAction.Style
    let tag: Int
    
    public init(
        title: String,
        style: UIAlertAction.Style,
        tag: Int
    ) {
        self.title = title
        self.style = style
        self.tag = tag
    }
}

public extension MMSUIWraper where T: UIAlertController {
    
    /// 一行代码调用弹窗
    ///
    /// - Parameters:
    ///     - containerController: 在哪个控制器页面弹出
    ///     - actionModels: 按钮model，可以传递多个
    ///     - extraConfig: 设置额外参数的回调，比如可以在此添加输入框
    ///     - completion: 弹出后的回调
    ///     - clickHandler: 点击按钮时的回调，通过tag来判断点击的是哪个按钮
    ///
    /// - Returns: UIAlertController
    @discardableResult
    static func showAlert(
        _ containerController: UIViewController,
        preferredStyle: T.Style,
        title: String?,
        message: String?,
        actionModels: MMSActionModel...,
        extraConfig: ((T) -> Void)?,
        completion: (() -> Void)?,
        clickHandler: ((UIAlertAction, Int) -> Void)?
    ) -> T {
        
        let alertController = T(title: title, message: message, preferredStyle: preferredStyle)
        for model in actionModels {
            let action = UIAlertAction(title: model.title, style: model.style) { (innerAction) in
                let actionTag = objc_getAssociatedObject(innerAction, &MMSUIAlertActionKey) as? Int ?? 0
                clickHandler?(innerAction, actionTag)
            }
            objc_setAssociatedObject(action, &MMSUIAlertActionKey, model.tag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            alertController.addAction(action)
        }
        extraConfig?(alertController)
        containerController.present(alertController, animated: true, completion: completion)
        return alertController
    }
}
