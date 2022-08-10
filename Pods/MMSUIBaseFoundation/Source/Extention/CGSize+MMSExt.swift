//
//  MMSize.swift
//  MomoChat
//
//  Created by ji.linlin on 2019/10/8.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

import UIKit
import MMFrameManager

/// 实时宽高, 跟随屏幕旋转发生改变
public var ScreenRealTimeWidth: CGFloat     { return UIScreen.main.bounds.width }
public var ScreenRealTimeHeight: CGFloat    { return UIScreen.main.bounds.height }

/// 竖屏宽高
public var ScreenWidth: CGFloat             = MDScreenInstance.shared().screenWidth
public var ScreenHeight: CGFloat            = MDScreenInstance.shared().screenHeight

/// 屏幕水平方向中间
public var ScreenWidthHalf: CGFloat         = ScreenWidth * 0.5
/// 分割线高度 0.5
public let SeparateLineHeight: CGFloat      = 0.5
/// 分割线高度 1
public let SeparateLineHeight1: CGFloat     = 1
/// 状态栏高度
public var STATUS_BAR_HEIGHT: CGFloat       = FrameManager.statusBarHeight()
/// 导航栏高度
public let NAV_BAR_HEIGHT: CGFloat          = 44.0
/// 屏幕上方高度
public var SCREEN_TOP_INSET: CGFloat        = (SAFEAREA_TOP_MARGIN + NAV_BAR_HEIGHT)
/// 屏幕上方高度
public var SCREEN_SAFE_HEIGHT: CGFloat      = (ScreenHeight - HOME_INDICATOR_HEIGHT)
/// 内容高
public var SCREEN_CONTENT_HEIGHT: CGFloat   = (ScreenHeight - SCREEN_TOP_INSET)

public var HOME_INDICATOR_HEIGHT: CGFloat   = FrameManager.homeIndicatorHeight()
public var SENSOR_HOUSING_HEIGHT: CGFloat   = FrameManager.sensorHousingHeight()
/// tabbar高度
public var TAB_BAR_HEIGHT: CGFloat          = HOME_INDICATOR_HEIGHT + 45
/// 刘海真实的高度
public var SAFEAREA_FRINGE_HEIGHT: CGFloat  = SENSOR_HOUSING_HEIGHT
/// 安全区域上方高度
public var SAFEAREA_TOP_MARGIN: CGFloat     = FrameManager.safeAreaTopMargin()
/// 安全区域下方高度
public var SAFEAREA_BOTTOM_MARGIN: CGFloat  = HOME_INDICATOR_HEIGHT
/// 一像素
public var ONE_PX: CGFloat                  = FrameManager.onePX()
/// 自适应比率
public var SIZE_RATIO: CGFloat              = ScreenWidth / 375.0
public var IS_IPHONE_X: Bool                = FrameManager.isIPhoneX()

public var TabSegmentViewDefaultHeight: CGFloat = 50
public var TabSegmentViewContentInset: CGFloat = SCREEN_TOP_INSET + TabSegmentViewDefaultHeight

public extension CGSize {
    
    static func adaptSize(_ size: CGFloat) -> CGFloat {
        return ceil(size * SIZE_RATIO)
    }
    
    /// size计算
    static func sizeDrawString(text: String?, font: UIFont, maxSize: CGSize) -> CGSize {
        guard let text = text else {
            return CGSize.zero
        }
        let textSize = text.boundingRect(with: maxSize,
                                         options: [
                                            .usesLineFragmentOrigin,
                                            .usesFontLeading,
                                            .truncatesLastVisibleLine
                                         ],
                                         attributes: [NSAttributedString.Key.font: font],
                                         context: nil).size
        return textSize
    }

    /// size计算（指定行数）
    static func sizeDrawString(text: String?, font: UIFont, maxWidth: CGFloat, line: Int) -> CGSize {
        guard let text = text else {
            return CGSize.zero
        }
        if line <= 0 {
            return sizeDrawString(text: text, font: font, maxSize: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        }
        let label = UILabel()
        label.text = text
        label.font = font
        label.mms.width = maxWidth
        label.numberOfLines = line
        label.sizeToFit()
        let height = label.frame.size.height
        let width = label.frame.size.width > maxWidth ? maxWidth : label.frame.size.width
        return CGSize(width: width, height: height)
     }
}
