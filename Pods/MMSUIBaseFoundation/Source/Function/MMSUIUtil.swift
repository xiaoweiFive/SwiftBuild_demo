//
//  MMSUIBaseFoundationUtil.swift
//  MMSUIBaseFoundation
//
//  Created by ji.linlin on 2021/1/14.
//

import UIKit

public enum MMSUIUtil {
    
}
public extension MMSUIUtil {

    /// 状态栏小菊花
    static func showNetworkActivityIndicator(_ show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    /// 取消第一响应者
    static func resignFirstResponder() {
        let sel = "firstResponder"
        if let unmanagedObject = UIApplication.shared.keyWindow?.perform(Selector(sel)),
           let view = unmanagedObject.takeUnretainedValue() as? UIView {
            view.resignFirstResponder()
        }
    }
    
    static func isDisplayedInScreen(view: UIView?) -> Bool {
        guard let view = view, let _ = view.superview, !view.isHidden else {
            return false
        }
        let rect = view.convert(view.frame, to: nil)
        //如果可以滚动，清除偏移量
        if rect == CGRect.zero || rect.size == CGSize.zero {
            return false
        }
        let screenRect = UIScreen.main.bounds
        let intersectionRect = screenRect.intersection(rect)
        if intersectionRect == CGRect.zero {
            return false
        }
        return true
    }

}
