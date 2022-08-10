//
//  UIFont+MMSExt.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/11/6.
//

import Foundation
import UIKit

public extension MMSUIWraper where T: UIFont {
    static func system(_ fontSize: CGFloat, _ needAdapt: Bool = false) -> UIFont {
        let size: CGFloat = needAdapt ? CGSize.adaptSize(fontSize) : fontSize
        return UIFont.systemFont(ofSize: size)
    }
    
    static func bold(_ fontSize: CGFloat, _ needAdapt: Bool = false) -> UIFont {
        let size: CGFloat = needAdapt ? CGSize.adaptSize(fontSize) : fontSize
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func getCustomFont(_ fontSize: CGFloat, _ fontName: String, _ needAdapt: Bool = false) -> UIFont {
        let size: CGFloat = needAdapt ? CGSize.adaptSize(fontSize) : fontSize
        let font = UIFont.init(name: fontName, size: size)
        if let newFont = font {
            return newFont
        }
        return system(fontSize)
    }
}
