//
//  MMSScrollLabelAnimationHandling.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

extension MMSScrollLabel {
    
    func labelShouldScroll() -> Bool {
        guard let context = substitute.text, !context.isEmpty else { return false }
        let contextLarge = (substituteSize().width + leadingBuffer) > bounds.size.width + CGFloat.ulpOfOne
        let duration = speed.value > 0.0
        return (!labelize && contextLarge && duration)
    }
    
    func timingFunctionForAnimationCurve(_ curve: UIView.AnimationCurve) -> CAMediaTimingFunction {
        let functionName: CAMediaTimingFunctionName
        switch curve {
        case .easeIn:
            functionName = .easeIn
        case .easeInOut:
            functionName = .easeInEaseOut
        case .easeOut:
            functionName = .easeOut
        default:
            functionName = .linear
        }
        return CAMediaTimingFunction(name: functionName)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let setupAnim = anim as? CABasicAnimation {
            if let finalColors = setupAnim.toValue as? [CGColor] {
                maskLayer?.colors = finalColors
            }
            maskLayer?.removeAnimation(forKey: "setupFade")
        } else {
            scrollCompletionBlock?(flag)
        }
    }
}
