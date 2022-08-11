//
//  MMColor.swift
//  MomoChat
//
//  Created by ji.linlin on 2019/10/8.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

import UIKit

/// 16进制数字转换为颜色(0xAARRGGBB, 0xRRGGBB)
public func hex(_ value: Int) -> UIColor {
    
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0;
    var a: CGFloat = 0xFF
    var rgb = value

    //带alpha值的8位hex (0xAARRGGBB)
    if value & 0xFF000000 > 0 {
        a = CGFloat((value & 0xFF000000) >> 24)
        rgb = value & 0x00FFFFFF
    }
    r = CGFloat((rgb & 0x00FF0000) >> 16)
    g = CGFloat((rgb & 0x0000FF00) >> 8)
    b = CGFloat(rgb & 0x000000FF)
    
    
    //print("r:%X g:%X b:%X a:%X", r, g, b, a)
    
    return UIColor(red: CGFloat(r) / 255.0,
                   green: CGFloat(g) / 255.0,
                   blue: CGFloat(b) / 255.0,
                   alpha: CGFloat(a) / 255.0)
}

/// 16进制字符串转换`UIColor`, 兼容 “0xARGB”、“0xRGB”
public func hex(_ value: String) -> UIColor {
    
    var hexString = ""
    if value.lowercased().hasPrefix("0x") {
        hexString = value.lowercased().replacingOccurrences(of: "0x", with: "")
    }
    else if value.hasPrefix("#") {
        hexString = value.replacingOccurrences(of: "#", with: "")
    }
    else {
        hexString = value
    }
    
    if hexString.count <= 4 {
        guard let hexInt = Int(hexString, radix: 16) else {
            return UIColor.clear
        }
        
        return shortHex(hexInt)
    }
    else {
        guard let hexInt = Int(hexString, radix: 16) else {
            return UIColor.clear
        }
        
        return hex(hexInt)
    }
}

/// 3-4位hex，如0xARGB、0xRGB
public func shortHex(_ value: Int) -> UIColor {
    
    var r: Int = 0, g: Int = 0, b: Int = 0;
    var a: Int = 0xFF
    var rgb = value
    
    // 带alpha值的hex(ARGB)
    if value & 0xF000 > 0 {
        a = (value & 0xF000) >> 12
        rgb = value & 0x0FFF
    }
    else {
        a = 0xF
        rgb = value
    }
    
    r = (rgb & 0x0F00) >> 8
    // 把R、G、B 凑成2位
    // 左移一位然后把r放后面，最终成为rr
    r |= (r << 4)
    
    g = (rgb & 0x00F0) >> 4
    g |= (g << 4)
    
    b = rgb & 0x000F
    b |= (b << 4)
    
    a |= (a << 4)
    
    return UIColor(red: CGFloat(r) / 255.0,
                   green: CGFloat(g) / 255.0,
                   blue: CGFloat(b) / 255.0,
                   alpha: CGFloat(a) / 255.0)
}

/// rgb alpha -> UIColor
public func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: (red)/255.0,
                   green: (green)/255.0,
                   blue: (blue)/255.0,
                   alpha: alpha)
}
   
public extension MMSUIWraper where T: UIColor {
    
    /// hex string/int -> UIColor
    static func hex<T>(_ hex: T, _ alpha: CGFloat = 1.0) -> UIColor {
        if !(hex is String || hex is Int) {
            return UIColor.black
        }
        
        var hexInt: Int = 0
        if hex is Int {
            hexInt = hex as! Int
        }
        if hex is String {
            var hexString = hex as! String
            if hexString.hasPrefix("#") {
                hexString = String(hexString[hexString.index(after: hexString.startIndex)...])
            }
            guard let hexVal = Int(hexString, radix: 16) else {
                return UIColor.black
            }
            hexInt = hexVal
        }
        return UIColor(red:   CGFloat((hexInt & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hexInt & 0x00FF00) >> 8) / 255.0,
                       blue:  CGFloat((hexInt & 0x0000FF) >> 0) / 255.0,
                       alpha: CGFloat(alpha))
    }
    
    /// 随机颜色
    static func random() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public extension MMSUIWraper where T: UIColor {
    /// "255,255,255" 转为颜色
    /// - Parameter str: "255, 255, 255"，"255, 255, 255, 0.1"
    /// - Returns: UIColor
    static func rgbString(_ str: String) -> UIColor? {
        let newStrs = str.trimmingCharacters(in: .whitespaces).split(separator: ",")
        if 3...4 ~= newStrs.count {
            let rgbs = newStrs.compactMap { numStr -> CGFloat? in
                if let dNum = Double(numStr) {
                    return CGFloat(dNum)
                }
                return nil
            }
            if rgbs.count != newStrs.count {
                return nil
            }
            let alpha: CGFloat = (rgbs.count == 4) ? rgbs[3] : 1
            return rgba(rgbs[0], rgbs[1], rgbs[2], alpha)
        }
        return nil
    }
}
