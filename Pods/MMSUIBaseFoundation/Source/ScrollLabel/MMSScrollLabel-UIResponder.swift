//
//  MMSScrollLabel-UIResponder.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation
 
extension UIResponder {
    public func firstAvailableViewController() -> UIViewController? {
        return traverseResponderChainForFirstViewController()
    }
    
    public func traverseResponderChainForFirstViewController() -> UIViewController? {
        if let nextResponder = next {
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            } else if nextResponder is UIView {
                return nextResponder.traverseResponderChainForFirstViewController()
            } else {
                return nil
            }
        }
        return nil
    }
}
