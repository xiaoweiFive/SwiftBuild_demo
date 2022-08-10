//
//  UIImage+MDUtility.swift
//  MomoChat
//
//  Created by ji.linlin on 2019/9/16.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

import UIKit

public extension MMSUIWraper where T: UIImage {
    
    /// 生成纯色图片
    static func createPureImage(_ color: UIColor, _ finalSize: CGSize, _ cornerRadius: CGFloat) -> UIImage? {
        let radius = max(cornerRadius, 0)
        let rect = CGRect(x: 0, y: 0, width: finalSize.width, height: finalSize.height)
        UIGraphicsBeginImageContextWithOptions(finalSize, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext()
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        bezierPath.addClip()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img
    }
    
    /// view截屏
    static func screenShot(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        return UIImage()
    }
}
