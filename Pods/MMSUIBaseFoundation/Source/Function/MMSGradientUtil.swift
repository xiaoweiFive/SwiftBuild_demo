//
//  MMSUIBaseFoundationUtil.swift
//  MMSUIBaseFoundation
//
//  Created by ji.linlin on 2020/12/15.
//

import UIKit

public struct MMSGradientUtil {
    private init() {}
}
public extension MMSGradientUtil {
    
    enum Direction {
        case horizontal // 水平
        case vertical   // 垂直
    }
    
    /// 渐变色 layer
    static func createGradientLayer(size: CGSize,
                                    colors: [CGColor],
                                    direction: MMSGradientUtil.Direction = .horizontal) -> CAGradientLayer
    {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        layer.colors = colors
        layer.locations = [0,1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        switch direction {
        case .horizontal:
            layer.endPoint = CGPoint(x: 1, y: 0)
        case .vertical:
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        return layer
    }
    
    /// 渐变色 image
    static func createGradientImage(size: CGSize,
                                    colors: [CGColor],
                                    direction: MMSGradientUtil.Direction = .horizontal) -> UIImage
    {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        view.layer.addSublayer(createGradientLayer(size: size, colors: colors, direction: direction))
        return UIImage.mms.screenShot(view: view)
    }
    
    /// 渐变色 imageView
    static func createGradientImageView(size: CGSize,
                                        colors: [CGColor],
                                        direction: MMSGradientUtil.Direction = .horizontal) -> UIImageView
    {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = createGradientImage(size: size, colors: colors, direction: direction)
        return imageView
    }
}

