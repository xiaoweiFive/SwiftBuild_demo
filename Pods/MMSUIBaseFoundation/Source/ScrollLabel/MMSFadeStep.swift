//
//  MMSFadeStep.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

/// 用来承接 ScrollStep 结束后淡入淡出的状态.
public struct MMSFadeStep: MMSScrollLabelStep {
    
    public typealias EdgeFade = MMSEdgeFade
    
    /// 与前一个 ScrollStep 后一个 ScrollStep 时间
    public let timeStep: CGFloat
    
    /// Step 与 Step 之间的动画曲线
    public let timingFunction: UIView.AnimationCurve
    
    /// 渐变步骤的边缘状态
    public let edgeFades: EdgeFade
    
    public init(timeStep: CGFloat,
         timingFunction: UIView.AnimationCurve = .linear,
         edgeFades: EdgeFade) {
        self.timeStep = timeStep
        self.timingFunction = timingFunction
        self.edgeFades = edgeFades
    }
}
