//
//  MMSScrollStep.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

/// 每一个 Step 表现的数据结构
public struct MMSScrollStep: MMSScrollLabelStep {
    
    public typealias EdgeFade = MMSEdgeFade
    
    public enum Position {
        case home
        case away
        case partial(CGFloat)
    }
    
    /// 每一个 Step 持续的时间
    public let timeStep: CGFloat
    
    /// Step 与 Step 之间的动画曲线
    public let timingFunction: UIView.AnimationCurve
    
    /// 滚动的位置
    public let position: Position
    
    /// 淡入淡出
    public let edgeFades: EdgeFade
    
    public init(timeStep: CGFloat,
         timingFunction: UIView.AnimationCurve = .linear,
         position: Position,
         edgeFades: EdgeFade) {
        self.timeStep = timeStep
        self.position = position
        self.edgeFades = edgeFades
        self.timingFunction = timingFunction
    }
}
