//
//  MMSScrollLabelStep.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

/// Step 表现的数据结构约束
public protocol MMSScrollLabelStep {
    
    typealias EdgeFade = MMSEdgeFade
    
    var timeStep: CGFloat { get }
    
    var timingFunction: UIView.AnimationCurve { get }
    
    var edgeFades: EdgeFade { get }
}
