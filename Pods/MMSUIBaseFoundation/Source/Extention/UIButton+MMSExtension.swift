//
//  UIButton+MMSExtension.swift
//  MMSUIBaseFoundation
//
//  Created by Zero.D.Saber on 2021/2/5.
//

import Foundation

/// https://gist.github.com/dreymonde/f1762cb435c6ee4ae077da73d9e21fa0

public extension MMSUIWraper where T: UIImage {
    
    /// 根据传入的颜色参数生成一张纯色图片
    static func generatePixel(ofColor color: UIColor) -> UIImage {
        let pixel = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(pixel.size)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setFillColor(color.cgColor)
        context.fill(pixel)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    /// 为不同模式设置不同底色
    @available(iOS 12.0, *)
    static func generatePixel(ofColor color: UIColor, userInterfaceStyle: UIUserInterfaceStyle) -> UIImage {
        var image: UIImage!
        if #available(iOS 13.0, *) {
            UITraitCollection(userInterfaceStyle: userInterfaceStyle).performAsCurrent {
                image = Self.generatePixel(ofColor: color)
            }
        } else {
            image = Self.generatePixel(ofColor: color)
        }
        return image
    }
    
    /// 支持模式切换的颜色设置
    /// - Parameter color: 颜色
    @available(iOS 12.0, *)
    static func pixel(ofColor color: UIColor) -> UIImage {
        let lightModeImage = generatePixel(ofColor: color, userInterfaceStyle: .light)
        let darkModeImage = generatePixel(ofColor: color, userInterfaceStyle: .dark)
        lightModeImage.imageAsset?.register(darkModeImage, with: UITraitCollection(userInterfaceStyle: .dark))
        return lightModeImage
    }
}

public extension MMSUIWraper where T: UIButton {
    
     /// Sets the background color of a button for a particular state.
     ///    - Parameter backgroundColor: The color to set.
     ///    - Parameter state: The state for the color to take affect.
    func setBackgroundColor(_ backgroundColor: UIColor, for state: UIControl.State) {
        if #available(iOS 12.0, *) {
            self.base.setBackgroundImage(UIImage.mms.pixel(ofColor: backgroundColor), for: state)
        } else {
            self.base.setBackgroundImage(UIImage.mms.generatePixel(ofColor: backgroundColor), for: state)
        }
    }
}
