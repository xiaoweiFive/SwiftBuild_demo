//
//  MMSScrollLabel.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import UIKit

/// 跑马灯 Label 主工程情感电台、十周年改版资料页等地方使用
public class MMSScrollLabel: UILabel, CAAnimationDelegate {
    
    public typealias AnimationCompletionBlock = (_ finished: Bool) -> Void
    public typealias ScrollLabelAnimation = (anim: CAKeyframeAnimation, duration: CGFloat)
    
    public typealias EdgeFade = MMSEdgeFade
    public typealias LabelStep = MMSScrollLabelStep
    public typealias ScrollStep = MMSScrollStep
    public typealias FadeStep = MMSFadeStep
    
    /// 设置滚动的方向
    public var type: ScrollType = .continuous {
        didSet {
            if type != oldValue {
                updateAndScroll()
            }
        }
    }
    
    /// 自定义的滚动的参数配置
    public var scrollSequence: [LabelStep]?
    public var animationCurve: UIView.AnimationCurve = .linear

    /// true 时移除所有的动画属性 ‘ScrollLabel’的属性 变成普通的 UILabel
    public var labelize: Bool = false {
        didSet {
            if labelize != oldValue {
                updateAndScroll()
            }
        }
    }
    
    /// 是否自动滚动 true 不自动滚动
    public var holdScrolling: Bool = false {
        didSet {
            if holdScrolling != oldValue, oldValue, !awayFromHome, !labelize, labelShouldScroll() {
                updateAndScroll()
            }
        }
    }
    
    /// 点击才开始滚动, true 点击开始滚动
    public var clickToStartScroll: Bool = false {
        didSet {
            if clickToStartScroll != oldValue {
                if clickToStartScroll {
                    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelWasTapped(_:)))
                    addGestureRecognizer(tapRecognizer)
                    isUserInteractionEnabled = true
                } else {
                    if let gesture = gestureRecognizers, let recognizer = gesture.first {
                        removeGestureRecognizer(recognizer)
                    }
                    isUserInteractionEnabled = false
                }
            }
        }
    }
    
    /// 当前是否是暂停状态 get only
    public var isPaused: Bool {
        return (substitute.layer.speed == 0.0)
    }
    
    /// 表示当前是否偏离设定的 Point, 表示是否正在进行滚动
    public var awayFromHome: Bool {
        if let presentationLayer = substitute.layer.presentation() {
            return presentationLayer.position.x != homeLabelFrame.origin.x
        }
        return false
    }
    
    /// 滚动文字区域和 Label 前边框的距离
    public var leadingBuffer: CGFloat = 0.0 {
        didSet {
            if leadingBuffer != oldValue {
                updateAndScroll()
            }
        }
    }
    
    /// 滚动文字区域和 Label 后边框的距离
    public var trailingBuffer: CGFloat = 0.0 {
        didSet {
            if trailingBuffer != oldValue {
                updateAndScroll()
            }
        }
    }
    
    /// 滚动文字前后渐隐透明度
    @objc public var fadeLength: CGFloat = 0.0 {
        didSet {
            if fadeLength != oldValue {
                applyGradientMask(fadeLength, animated: true)
                updateAndScroll()
            }
        }
    }
    
    /// 设置渐隐类型
    public var fadeType: FadeType = .onlyRight
    
    /// 滚动速度
    public var speed: SpeedLimit = .duration(7.0) {
        didSet {
            switch (speed, oldValue) {
            case (.rate(let rateA), .rate(let rateB)) where rateA == rateB:
                return
            case (.duration(let rateA), .duration(let rateB)) where rateA == rateB:
                return
            default:
                updateAndScroll()
            }
        }
    }
    
    /// 滚动完成后暂停的时间
    public var animationDelay: CGFloat = 1.0
    
    /// 滚动动画的持续时间
    public var animationDuration: CGFloat {
        switch speed {
        case .rate(let rate):
            return CGFloat(abs(awayOffset) / rate)
        case .duration(let duration):
            return duration
        }
    }
    
    public init(frame: CGRect, rate: CGFloat, fadeLength fade: CGFloat) {
        speed = .rate(rate)
        fadeLength = CGFloat(min(fade, frame.size.width/2.0))
        super.init(frame: frame)
        setup()
    }
    
    public init(frame: CGRect, duration: CGFloat, fadeLength fade: CGFloat) {
        speed = .duration(duration)
        fadeLength = CGFloat(min(fade, frame.size.width/2.0))
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override convenience init(frame: CGRect) {
        self.init(frame: frame, duration:5.0, fadeLength:0.0)
    }
    
    public var substitute = UILabel()
    public var homeLabelFrame = CGRect.zero
    public var awayOffset: CGFloat = 0.0
    
    override open class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    public weak var repliLayer: CAReplicatorLayer? {
        return layer as? CAReplicatorLayer
    }
    
    public weak var maskLayer: CAGradientLayer? {
        if let mask = layer.mask {
            return mask as? CAGradientLayer
        }
        return nil
    }
    
    public var scrollCompletionBlock: AnimationCompletionBlock?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 计算内容大小
    /// - Returns: CGSize
    public func substituteSize() -> CGSize {
        let maxLabelSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        var expectedSize = substitute.sizeThatFits(maxLabelSize)
        expectedSize.width = min(expectedSize.width, 5461.0)
        expectedSize.height = bounds.size.height
        return expectedSize
    }
}

extension MMSScrollLabel {
    
    private func setup() {
        substitute = UILabel(frame: bounds)
        substitute.tag = 5317
        substitute.layer.anchorPoint = .zero
        addSubview(substitute)
        
        super.clipsToBounds = true
        super.numberOfLines = 1
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MMSScrollLabel.restartForViewController(_:)),
                                               name: NSNotification.Name(rawValue: NotificationKey.restart.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MMSScrollLabel.labelizeForController(_:)),
                                               name: NSNotification.Name(rawValue: NotificationKey.labelize.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MMSScrollLabel.animateForController(_:)),
                                               name: NSNotification.Name(rawValue: NotificationKey.animate.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MMSScrollLabel.restartLabel),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(MMSScrollLabel.shutdownLabel),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }
    
}

extension MMSScrollLabel {
    
    /// 文字滚动方向
    public enum ScrollType {
        case left
        case leftRight
        case right
        case rightLeft
        case continuous
        case continuousReverse
    }
    
    /// 渐隐配置 onlyLeft 只有左边渐隐， onlyright 只有右边渐隐， `default` 默认前后都有
    public enum FadeType {
        case onlyLeft
        case onlyRight
        case `default`
    }
    
    /// 滚动速度和速率
    public enum SpeedLimit {
        case rate(CGFloat)
        case duration(CGFloat)
        
        var value: CGFloat {
            switch self {
            case .rate(let rate):
                return rate
            case .duration(let duration):
                return duration
            }
        }
    }
    
    public enum NotificationKey: String {
        case restart = "ScrollLabelControllerRestart"
        case labelize = "ScrollLabelLabelize"
        case animate = "ScrollLabelAnimate"
        case completionClosure = "ScrollLabelAnimationCompletion"
    }
}

// MARK: - ScrollLabel 默认方法
extension MMSScrollLabel {
    
    override open func draw(_ layer: CALayer, in ctx: CGContext) {
        if let bgColor = backgroundColor {
            ctx.setFillColor(bgColor.cgColor)
            ctx.fill(layer.bounds)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        forwardPropertiesToSublabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateAndScroll()
    }
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            shutdownLabel()
        }
    }
    
    public override func didMoveToWindow() {
        if window == nil {
            shutdownLabel()
        } else {
            updateAndScroll()
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fitSize = substitute.sizeThatFits(size)
        fitSize.width += leadingBuffer
        return fitSize
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        forwardPropertiesToSublabel()
    }
    
    private func forwardPropertiesToSublabel() {
        let properties = ["baselineAdjustment",
                          "enabled",
                          "highlighted",
                          "highlightedTextColor",
                          "minimumFontSize",
                          "shadowOffset",
                          "textAlignment",
                          "userInteractionEnabled",
                          "adjustsFontSizeToFitWidth",
                          "lineBreakMode",
                          "numberOfLines",
                          "contentMode"]
        
        substitute.text = super.text
        substitute.font = super.font
        substitute.textColor = super.textColor
        substitute.backgroundColor = super.backgroundColor ?? .clear
        substitute.shadowColor = super.shadowColor
        substitute.shadowOffset = super.shadowOffset
        
        for propertie in properties {
            let value = super.value(forKey: propertie)
            substitute.setValue(value, forKey: propertie)
        }
    }
}

// MARK:  默认属性
extension MMSScrollLabel {
    public override var text: String? {
        get {
            return substitute.text
        }
        
        set {
            if newValue != substitute.text {
                substitute.text = newValue
                updateAndScroll()
                super.text = text
            }
        }
    }
    
    public override var attributedText: NSAttributedString? {
        get {
            return substitute.attributedText
        }
        
        set {
            if substitute.attributedText != newValue {
                substitute.attributedText = newValue
                updateAndScroll()
                super.attributedText = attributedText
            }
        }
    }
    
    public override var font: UIFont! {
        get {
            return substitute.font
        }
        
        set {
            if substitute.font != newValue {
                substitute.font = newValue
                super.font = newValue
                updateAndScroll()
            }
        }
    }
    
    public override var textColor: UIColor! {
        get {
            return substitute.textColor
        }
        
        set {
            substitute.textColor = newValue
            super.textColor = newValue
        }
    }
    
    override open var backgroundColor: UIColor? {
        get {
            return substitute.backgroundColor
        }
        
        set {
            substitute.backgroundColor = newValue
            super.backgroundColor = newValue
        }
    }
    
    public override var shadowColor: UIColor? {
        get {
            return substitute.shadowColor
        }
        
        set {
            substitute.shadowColor = newValue
            super.shadowColor = newValue
        }
    }
    
    public override var shadowOffset: CGSize {
        get {
            return substitute.shadowOffset
        }
        
        set {
            substitute.shadowOffset = newValue
            super.shadowOffset = newValue
        }
    }
    
    
    public override var highlightedTextColor: UIColor? {
        get {
            return substitute.highlightedTextColor
        }
        
        set {
            substitute.highlightedTextColor = newValue
            super.highlightedTextColor = newValue
        }
    }
    
    public override var isHighlighted: Bool {
        get {
            return substitute.isHighlighted
        }
        
        set {
            substitute.isHighlighted = newValue
            super.isHighlighted = newValue
        }
    }
    
    public override var isEnabled: Bool {
        get {
            return substitute.isEnabled
        }
        
        set {
            substitute.isEnabled = newValue
            super.isEnabled = newValue
        }
    }
    
    public override var numberOfLines: Int {
        get {
            return super.numberOfLines
        }
        
        set {
            super.numberOfLines = 1
        }
    }
    
    public override var adjustsFontSizeToFitWidth: Bool {
        get {
            return super.adjustsFontSizeToFitWidth
        }
        
        set {
            super.adjustsFontSizeToFitWidth = false
        }
    }
    
    override open var minimumScaleFactor: CGFloat {
        get {
            return super.minimumScaleFactor
        }
        
        set {
            super.minimumScaleFactor = 0.0
        }
    }
    
    public override var baselineAdjustment: UIBaselineAdjustment {
        get {
            return substitute.baselineAdjustment
        }
        
        set {
            substitute.baselineAdjustment = newValue
            super.baselineAdjustment = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        var content = substitute.intrinsicContentSize
        content.width += leadingBuffer
        return content
    }
    
    public override var tintColor: UIColor! {
        get {
            return substitute.tintColor
        }
        
        set {
            substitute.tintColor = newValue
            super.tintColor = newValue
        }
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        substitute.tintColorDidChange()
    }
    
    public override var contentMode: UIView.ContentMode {
        get {
            return substitute.contentMode
        }
        
        set {
            super.contentMode = contentMode
            substitute.contentMode = newValue
        }
    }
    
    public override var isAccessibilityElement: Bool {
        didSet {
            substitute.isAccessibilityElement = isAccessibilityElement
        }
    }
}
