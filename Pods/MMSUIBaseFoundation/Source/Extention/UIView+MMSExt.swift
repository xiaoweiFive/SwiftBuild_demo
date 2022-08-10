//
//  UIView+MMSExtention.swift
//  MMSUIBaseFoundation
//
//  Created by Zero.D.Saber on 2020/11/10.
//

public extension MMSUIWraper where T: UIView {
    
    /// 使用贝塞尔曲线给视图切圆角
    @discardableResult
    func roundCorners(_ corners: UIRectCorner,
                      radius: CGFloat) -> T {
        let path = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.base.layer.mask = mask
        return self.base
    }
    
    /// 使用`maskedCorners`给视图切圆角
    @available(macOS 10.13, iOS 11.0, tvOS 11, *)
    @discardableResult
    func roundCorners(_ corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner],
                      radius: CGFloat) -> T {
        self.base.layer.cornerRadius = radius
        self.base.layer.maskedCorners = corners
        return self.base
    }
    
    /// 获取view所在的控制器
    func viewController() -> UIViewController? {
        var nextResponder: UIResponder? = self.base
        while nextResponder != nil {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
    
    /// 添加多个子视图
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { self.base.addSubview($0) }
    }
}
