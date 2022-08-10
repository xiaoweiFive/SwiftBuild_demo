//
//  MMSScrollLabelAction.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import UIKit

extension MMSScrollLabel {
    
    @objc public func restartLabelSpecial() {
        shutdownLabel()
        if labelShouldScroll(),
           !clickToStartScroll,
           !holdScrolling {
            updateAndScrollSpecial()
        }
    }
    
    public func updateAndScrollSpecial() {
        updateAndScrollSpecial(overrideHold: false)
    }
    
    public func updateAndScrollSpecial(overrideHold: Bool) {
        guard labelReadyForScroll() else { return }
        
        let expectedLabelSize = substituteSize()
        invalidateIntrinsicContentSize()
        returnLabelToHome()
        
        if !labelShouldScroll() {
            labelShouldScrollEmpty()
            return
        }
        
        let sequence: [LabelStep]
        switch type {
        case .continuous, .continuousReverse:
            sequence = continuousAndReverseSpecial(expectedSize: expectedLabelSize)
        case .leftRight, .left, .rightLeft, .right:
            sequence = anyLeftOrRight(expectedSize: expectedLabelSize)
        }
        applyGradientMask(fadeLength, animated: !self.labelize)
        if overrideHold || (!holdScrolling && !overrideHold) {
            beginScroll(sequence)
        }
    }
    
    /// type is .continuous, .continuousReverse
    func continuousAndReverseSpecial(expectedSize: CGSize) -> [LabelStep] {
        let minTrailing = max(leadingBuffer, trailingBuffer, fadeLength)
        if type == .continuous {
            homeLabelFrame = CGRect(x: leadingBuffer, y: 0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = -(homeLabelFrame.size.width + minTrailing)
        } else {
            homeLabelFrame = CGRect(x: bounds.size.width - (expectedSize.width + leadingBuffer), y: 0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = (homeLabelFrame.size.width + minTrailing)
        }
        
        let offsetDistance = awayOffset
        let offscreenAmount = homeLabelFrame.size.width
        let startFadeFraction = abs(offscreenAmount / offsetDistance)
        
        let startFadeTimeFraction = timingFunctionForAnimationCurve(animationCurve).durationPercentageForPositionPercentage(startFadeFraction, duration: (animationDelay + animationDuration))
        let startFadeTime = startFadeTimeFraction * animationDuration
        
        substitute.frame = homeLabelFrame
        repliLayer?.instanceCount = 2
        repliLayer?.instanceTransform = CATransform3DMakeTranslation(-awayOffset, 0.0, 0.0)
        
        let sequences: [LabelStep] = [ScrollStep(timeStep: 0.0, position: .home, edgeFades: .trailing),
                                      FadeStep(timeStep: (startFadeTime - animationDuration), edgeFades: [.leading, .trailing]),
                                      ScrollStep(timeStep: animationDuration, timingFunction: animationCurve, position: .away, edgeFades: .trailing),
                                      FadeStep(timeStep: 0.2, edgeFades: [.leading, .trailing]),
                                      ScrollStep(timeStep: animationDelay, position: .away, edgeFades: .trailing)]
        return scrollSequence ?? sequences
        return scrollSequence ?? sequences
    }
}

extension MMSScrollLabel {
    
    public func updateAndScroll() {
        updateAndScroll(overrideHold: false)
    }
    
    func updateAndScroll(overrideHold: Bool) {
        guard labelReadyForScroll() else { return }
        
        let expectedLabelSize = substituteSize()
        invalidateIntrinsicContentSize()
        returnLabelToHome()
        
        if !labelShouldScroll() {
            labelShouldScrollEmpty()
            return
        }
        
        let sequence: [LabelStep]
        switch type {
        case .continuous, .continuousReverse:
            sequence = continuousAndReverse(expectedSize: expectedLabelSize)
        case .leftRight, .left, .rightLeft, .right:
            sequence = anyLeftOrRight(expectedSize: expectedLabelSize)
        }
        applyGradientMask(fadeLength, animated: !self.labelize)
        if overrideHold || (!holdScrolling && !overrideHold) {
            beginScroll(sequence)
        }
    }
    
    /// type is .continuous, .continuousReverse
    func continuousAndReverse(expectedSize: CGSize) -> [LabelStep] {
        let minTrailing = max(leadingBuffer, trailingBuffer, fadeLength)
        if type == .continuous {
            homeLabelFrame = CGRect(x: leadingBuffer, y: 0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = -(homeLabelFrame.size.width + minTrailing)
        } else {
            homeLabelFrame = CGRect(x: bounds.size.width - (expectedSize.width + leadingBuffer), y: 0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = (homeLabelFrame.size.width + minTrailing)
        }
        
        let offsetDistance = awayOffset
        let offscreenAmount = homeLabelFrame.size.width
        let startFadeFraction = abs(offscreenAmount / offsetDistance)
        
        let startFadeTimeFraction = timingFunctionForAnimationCurve(animationCurve).durationPercentageForPositionPercentage(startFadeFraction, duration: (animationDelay + animationDuration))
        let startFadeTime = startFadeTimeFraction * animationDuration
        
        substitute.frame = homeLabelFrame
        repliLayer?.instanceCount = 2
        repliLayer?.instanceTransform = CATransform3DMakeTranslation(-awayOffset, 0.0, 0.0)
        
        let sequences: [LabelStep] = [ScrollStep(timeStep: 0.0, position: .home, edgeFades: .trailing),
                                              ScrollStep(timeStep: animationDelay, position: .home, edgeFades: .trailing),
                                              FadeStep(timeStep: 0.2, edgeFades: [.leading, .trailing]),
                                              FadeStep(timeStep: (startFadeTime - animationDuration), edgeFades: [.leading, .trailing]),
                                              ScrollStep(timeStep: animationDuration, timingFunction: animationCurve, position: .away, edgeFades: .trailing)]
        return scrollSequence ?? sequences
    }
    
    /// .leftRight, .left, .rightLeft, .right
    /// - Parameter expectedSize: expectedSize
    /// - Returns: [ScrollLabelStep]
    func anyLeftOrRight(expectedSize: CGSize) -> [LabelStep] {
        if type == .leftRight || type == .left {
            homeLabelFrame = CGRect(x: leadingBuffer, y: 0.0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = bounds.size.width - (expectedSize.width + leadingBuffer + trailingBuffer)
            substitute.textAlignment = .left
        } else {
            homeLabelFrame = CGRect(x: bounds.size.width - (expectedSize.width + leadingBuffer), y: 0.0, width: expectedSize.width, height: bounds.size.height).integral
            awayOffset = (expectedSize.width + trailingBuffer + leadingBuffer) - bounds.size.width
            substitute.textAlignment = .right
        }
        
        substitute.frame = homeLabelFrame
        repliLayer?.instanceCount = 1
        let sequences: [LabelStep]
        
        if type == .leftRight || type == .rightLeft {
            sequences = scrollSequence ?? [ScrollStep(timeStep: 0.0, position: .home, edgeFades: .trailing),
                                           ScrollStep(timeStep: animationDelay, position: .home, edgeFades: .trailing),
                                           FadeStep(timeStep: 0.2, edgeFades: [.leading, .trailing]),
                                           FadeStep(timeStep: -0.2, edgeFades: [.leading, .trailing]),
                                           ScrollStep(timeStep: animationDuration, timingFunction: animationCurve, position: .away, edgeFades: .leading),
                                           ScrollStep(timeStep: animationDelay, position: .away, edgeFades: .leading),
                                           FadeStep(timeStep: 0.2, edgeFades: [.leading, .trailing]),
                                           FadeStep(timeStep: -0.2, edgeFades: [.leading, .trailing]),
                                           ScrollStep(timeStep: animationDuration, timingFunction: animationCurve, position: .home, edgeFades: .trailing)]
        } else {
            sequences = scrollSequence ?? [ScrollStep(timeStep: 0.0, position: .home, edgeFades: .trailing),
                                           ScrollStep(timeStep: animationDelay, position: .home, edgeFades: .trailing),
                                           FadeStep(timeStep: 0.2, edgeFades: [.leading, .trailing]),
                                           FadeStep(timeStep: -0.2, edgeFades: [.leading, .trailing]),
                                           ScrollStep(timeStep: animationDuration, timingFunction: animationCurve, position: .away, edgeFades: .leading),
                                           ScrollStep(timeStep: animationDelay, position: .away, edgeFades: .leading)]
        }
        return sequences
    }
    
    func beginScroll(_ sequence: [LabelStep]) {
        let scroller = generateScrollAnimation(sequence)
        let fader = generateGradientAnimation(sequence, totalDuration: scroller.duration)
        scroll(scroller, fader: fader)
    }
    
    func scroll(_ scroller: ScrollLabelAnimation, fader: ScrollLabelAnimation?) {
        guard labelReadyForScroll() else { return }
        var fader = fader
        CATransaction.begin()
        CATransaction.setAnimationDuration(TimeInterval(scroller.duration))
        
        if fadeLength > 0.0 {
            setMaskLayerAnimation(fader: fader)
        } else {
            fader = nil
        }
        setScrollCompletionBlock(scroller, fader: fader)
        scroller.anim.setValue(true, forKey: NotificationKey.completionClosure.rawValue)
        scroller.anim.delegate = self
        if type == .left || type == .right {
            scroller.anim.isRemovedOnCompletion = false
            scroller.anim.fillMode = .forwards
        }
        substitute.layer.add(scroller.anim, forKey: "position")
        CATransaction.commit()
    }
    
    func setMaskLayerAnimation(fader: ScrollLabelAnimation?) {
        if let setupAnim = maskLayer?.animation(forKey: "setupFade") as? CABasicAnimation,
           let finalColors = setupAnim.toValue as? [CGColor] {
            maskLayer?.colors = finalColors
        }
        if let maskLayer = maskLayer {
            maskLayer.removeAnimation(forKey: "setupFade")
            if let previousAnimation = fader?.anim {
                maskLayer.add(previousAnimation, forKey: "gradient")
            }
        }
    }
    
    func setScrollCompletionBlock(_ scroller: ScrollLabelAnimation, fader: ScrollLabelAnimation?) {
        scrollCompletionBlock = { [weak self] (finished: Bool) in
            guard let weakSelf = self,
                  weakSelf.window != nil,
                  weakSelf.substitute.layer.animation(forKey: "position") == nil,
                  finished,
                  weakSelf.scrollCompletionBlock != nil else { return }
            if weakSelf.labelShouldScroll(),
               !weakSelf.clickToStartScroll,
               !weakSelf.holdScrolling {
                weakSelf.scroll(scroller, fader: fader)
            }
        }
    }
    
    /// 生产滚动动画
    /// - Parameter sequence: 动画展示数据
    /// - Returns: ScrollLabelAnimation: (anim: CAKeyframeAnimation, duration: CGFloat)
    func generateScrollAnimation(_ sequence: [LabelStep]) -> ScrollLabelAnimation {
        let homeOrigin = homeLabelFrame.origin
        let awayOrigin = offsetCGPoint(homeLabelFrame.origin, offset: awayOffset)
        let scrollSteps = sequence.compactMap { $0 as? ScrollStep }
        let totalDuration = scrollSteps.reduce(0.0) { $0 + $1.timeStep }
        
        var totalTime: CGFloat = 0.0
        var scrollKeyTimes = [NSNumber]()
        var scrollKeyValues = [NSValue]()
        var scrollTimingFunctions = [CAMediaTimingFunction]()
        
        for (offset, step) in scrollSteps.enumerated() {
            totalTime += step.timeStep
            scrollKeyTimes.append(NSNumber(value:Float(totalTime/totalDuration)))
            let scrollPosition: CGPoint
            switch step.position {
            case .home:
                scrollPosition = homeOrigin
            case .away:
                scrollPosition = awayOrigin
            case .partial(let frac):
                scrollPosition = offsetCGPoint(homeOrigin, offset: awayOffset*frac)
            }
            scrollKeyValues.append(NSValue(cgPoint:scrollPosition))
            
            if offset != 0 {
                scrollTimingFunctions.append(timingFunctionForAnimationCurve(step.timingFunction))
            }
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.keyTimes = scrollKeyTimes
        animation.values = scrollKeyValues
        animation.timingFunctions = scrollTimingFunctions
        
        return (anim: animation, duration: totalDuration)
    }
    
    func fadeStepsFadeSteps(_ sequence: [LabelStep]) -> [EnumeratedSequence<[MMSScrollLabel.LabelStep]>.Element] {
        let fadeSteps = sequence.enumerated().filter { (arg: (offset: Int, element: LabelStep)) -> Bool in
            let (offset, element) = arg
            if element is ScrollStep { return true }
            if offset == 0 { return false }
            let subsequent = element.timeStep >= 0 && (sequence[max(0, offset - 1)] is ScrollStep)
            let precedent = element.timeStep < 0 && (sequence[min(sequence.count - 1, offset + 1)] is ScrollStep)
            return (precedent || subsequent)
        }
        return fadeSteps
    }
    
    /// 生成渐变动画
    /// - Parameters:
    ///   - sequence: [ScrollLabelStep]
    ///   - totalDuration: 总持续时间
    /// - Returns: ScrollLabelAnimation
    func generateGradientAnimation(_ sequence: [LabelStep], totalDuration: CGFloat) -> ScrollLabelAnimation {
        var totalTime: CGFloat = 0.0
        var stepTime: CGFloat = 0.0
        var fadeKeyValues = [[CGColor]]()
        var fadeKeyTimes = [NSNumber]()
        var fadeTimingFunctions = [CAMediaTimingFunction]()
        let fadeSteps = fadeStepsFadeSteps(sequence)
        
        for (offset, step) in fadeSteps {
            if step is ScrollStep {
                totalTime += step.timeStep
                stepTime = totalTime
            } else {
                if step.timeStep >= 0 {
                    stepTime = totalTime + step.timeStep
                } else {
                    stepTime = totalTime + fadeSteps[offset + 1].element.timeStep + step.timeStep
                }
            }
            
            fadeKeyTimes.append(NSNumber(value:Float(stepTime/totalDuration)))
            
            let values: [CGColor] = getFadeKeyValues(type, step)
            fadeKeyValues.append(values)
            
            if offset != 0 {
                fadeTimingFunctions.append(timingFunctionForAnimationCurve(step.timingFunction))
            }
        }

        let animation = getFrameAnimation(fadeKeyValues, fadeKeyTimes, fadeTimingFunctions)
        return (anim: animation, duration: max(totalTime, totalDuration))
    }
    
    func getFadeKeyValues(_ type: ScrollType,_ step: MMSScrollLabel.LabelStep) -> [CGColor] {
        
        let transp = UIColor.clear.cgColor
        let opaque = UIColor.black.cgColor
        let values: [CGColor]
        
        let leading = step.edgeFades.contains(.leading) ? transp : opaque
        let trailing = step.edgeFades.contains(.trailing) ? transp : opaque
        
        switch type {
        case .leftRight, .left, .continuous:
            values = [leading, opaque, opaque, trailing]
        case .rightLeft, .right, .continuousReverse:
            values = [trailing, opaque, opaque, leading]
        }
        return values
    }
    
    func getFrameAnimation(_ values: [[CGColor]],_ keyTimes: [NSNumber], _ timingFunctions: [CAMediaTimingFunction]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "colors")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.timingFunctions = timingFunctions
        return animation
    }
    
    func offsetCGPoint(_ point: CGPoint, offset: CGFloat) -> CGPoint {
        return CGPoint(x: point.x + offset, y: point.y)
    }
    
    /// 渐变蒙版
    /// - Parameters:
    ///   - fadeLength: 滚动文字的前后透明度
    ///   - animated: 是否有动画
    ///   - ScrollLabelStep: 滚动的数据结构协议
    func applyGradientMask(_ fadeLength: CGFloat, animated: Bool) {
        if let layer = maskLayer {
            layer.removeAllAnimations()
        }
        if fadeLength <= 0.0 {
            removeGradientMask()
            return
        }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let gradientMask: CAGradientLayer
        if let currentMask = maskLayer {
            gradientMask = currentMask
        } else {
            gradientMask = CAGradientLayer()
            gradientMask.shouldRasterize = true
            gradientMask.rasterizationScale = UIScreen.main.scale
            gradientMask.startPoint = CGPoint(x:0.0, y:0.5)
            gradientMask.endPoint = CGPoint(x:1.0, y:0.5)
        }
        
        if gradientMask.bounds != layer.bounds {
            let leftFadeStop = fadeLength/bounds.size.width
            let rightFadeStop = 1.0 - fadeLength/bounds.size.width
            switch fadeType {
            case .onlyLeft:
                gradientMask.locations = [0.0, leftFadeStop, 1.0, 1.0].map { NSNumber(value: Float($0)) }
            case .onlyRight:
                gradientMask.locations = [0.0, 0.0, rightFadeStop, 1.0].map { NSNumber(value: Float($0)) }
            case .default:
                gradientMask.locations = [0.0, leftFadeStop, rightFadeStop, 1.0].map { NSNumber(value: Float($0)) }
            }
        }
        
        gradientMask.bounds = layer.bounds
        gradientMask.position = CGPoint(x:bounds.midX, y:bounds.midY)
        
        let transparent = UIColor.clear.cgColor
        let opaque = UIColor.black.cgColor
        
        layer.mask = gradientMask
        
        let adjustedColors: [CGColor]
        let trailingFadeNeeded = labelShouldScroll()
        
        switch type {
        case .continuousReverse, .rightLeft:
            adjustedColors = [(trailingFadeNeeded ? transparent : opaque), opaque, opaque, opaque]
        default:
            adjustedColors = [opaque, opaque, opaque, (trailingFadeNeeded ? transparent : opaque)]
        }
        
        if animated {
            CATransaction.commit()
            let colorAnimation = CABasicAnimation(keyPath: "colors")
            colorAnimation.fromValue = gradientMask.colors
            colorAnimation.toValue = adjustedColors
            colorAnimation.fillMode = .forwards
            colorAnimation.isRemovedOnCompletion = false
            colorAnimation.delegate = self
            gradientMask.add(colorAnimation, forKey: "setupFade")
        } else {
            gradientMask.colors = adjustedColors
            CATransaction.commit()
        }
    }
    
    private func labelShouldScrollEmpty() {
        substitute.textAlignment = super.textAlignment
        substitute.lineBreakMode = super.lineBreakMode
        
        let labelFrame: CGRect
        switch type {
        case .continuousReverse, .rightLeft:
            labelFrame = bounds.divided(atDistance: leadingBuffer, from: CGRectEdge.maxXEdge).remainder.integral
        default:
            labelFrame = CGRect(x: leadingBuffer, y: 0.0, width: bounds.size.width - leadingBuffer, height: bounds.size.height).integral
        }
        homeLabelFrame = labelFrame
        awayOffset = 0.0
        repliLayer?.instanceCount = 1
        substitute.frame = labelFrame
        removeGradientMask()
    }
    
    private func removeGradientMask() {
        layer.mask = nil
    }
    
    private func labelReadyForScroll() -> Bool {
        guard superview != nil, window != nil else { return false }
        if let viewController = firstAvailableViewController(), !viewController.isViewLoaded  {
            return false
        }
        return true
    }
    
    func returnLabelToHome() {
        maskLayer?.removeAllAnimations()
        substitute.layer.removeAllAnimations()
        scrollCompletionBlock = nil
    }
    
    @objc public func restartForViewController(_ notification: Notification) {
        if let controller = (notification as NSNotification).userInfo?["controller"] as? UIViewController, controller === firstAvailableViewController() {
            restartLabel()
        }
    }
    
    @objc public func labelizeForController(_ notification: Notification) {
        if let controller = (notification as NSNotification).userInfo?["controller"] as? UIViewController, controller === firstAvailableViewController() {
            labelize = true
        }
    }
    
    @objc public func animateForController(_ notification: Notification) {
        if let controller = (notification as NSNotification).userInfo?["controller"] as? UIViewController, controller === firstAvailableViewController()  {
            labelize = false
        }
    }
}
