//
//  MMSScrollLabelControl.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

extension MMSScrollLabel {
    
    /// 触发滚动
    public func triggerScrollStart() {
        if labelShouldScroll(), !awayFromHome {
            updateAndScroll()
        }
    }
    
    /// 重新启动滚动动画
    @objc public func restartLabel() {
        shutdownLabel()
        if labelShouldScroll(),
           !clickToStartScroll,
           !holdScrolling {
            updateAndScroll()
        }
    }
    
    
    /// 重置 Label, 取消所有的动画， 不会立即生效
    @objc public func shutdownLabel() {
        returnLabelToHome()
        applyGradientMask(fadeLength, animated: false)
    }
    
    public func pauseLabel() {
        guard !isPaused, awayFromHome else { return }
        /// 暂停位置动画
        let labelPauseTime = substitute.layer.convertTime(CACurrentMediaTime(), from: nil)
        substitute.layer.speed = 0.0
        substitute.layer.timeOffset = labelPauseTime
        
        /// 暂停渐变淡入淡出动画
        if let maskLayer = maskLayer {
            let gradientPauseTime = maskLayer.convertTime(CACurrentMediaTime(), from:nil)
            maskLayer.speed = 0.0
            maskLayer.timeOffset = gradientPauseTime
        }
    }
    
    /// 取消暂停之前暂停的文本滚动动画
    public func unpauseLabel() {
        guard isPaused else { return }
        /// 取消暂停位置动画
        let labelPausedTime = substitute.layer.timeOffset
        substitute.layer.speed = 1.0
        substitute.layer.timeOffset = 0.0
        substitute.layer.beginTime = 0.0
        substitute.layer.beginTime = substitute.layer.convertTime(CACurrentMediaTime(), from:nil) - labelPausedTime
        
        // 取消暂停渐变淡入淡出动画
        if let maskLayer = maskLayer {
            let gradientPauseTime = maskLayer.timeOffset
            maskLayer.speed = 1.0
            maskLayer.timeOffset = 0.0
            maskLayer.beginTime = 0.0
            maskLayer.beginTime = maskLayer.convertTime(CACurrentMediaTime(), from:nil) - gradientPauseTime
        }
    }
    
    /// 点击标签手势触发 Acton
    /// - Parameter recognizer: UIGestureRecognizer
    @objc public func labelWasTapped(_ recognizer: UIGestureRecognizer) {
        if labelShouldScroll(), !awayFromHome {
            updateAndScroll(overrideHold: true)
        }
    }
    
    public override func forBaselineLayout() -> UIView {
        return substitute
    }
    
    public override var forLastBaselineLayout: UIView {
        return substitute
    }
}
