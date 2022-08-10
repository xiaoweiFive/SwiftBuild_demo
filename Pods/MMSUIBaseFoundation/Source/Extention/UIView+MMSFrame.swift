//
//  UIView+Frame.swift
//  MomoChat
//
//  Created by ji.linlin on 2019/9/16.
//  Copyright © 2019 wemomo.com. All rights reserved.
//

import UIKit

public extension MMSUIWraper where T: UIView {
    
    var x: CGFloat {
        get {
            return self.base.frame.origin.x
        }
        set {
            self.base.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.base.frame.origin.y
        }
        set {
            self.base.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.base.frame.size.width
        }
        set {
            self.base.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.base.frame.size.height
        }
        set {
            self.base.frame.size.height = newValue
        }
    }
    
    var left: CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
    
    var top: CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.x + self.width * 0.5
        }
        set {
            self.x = newValue - self.width * 0.5
        }
    }
    
    var centerY: CGFloat {
        get {
            self.y + self.height * 0.5
        }
        set {
            self.y = newValue - self.height * 0.5
        }
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.centerX, y: self.centerY)
        }
        set {
            self.centerX = newValue.x
            self.centerY = newValue.y
        }
    }
    
    var boundsCenterX: CGFloat {
        return self.width * 0.5
    }
    
    var boundsCenterY: CGFloat {
        return self.height * 0.5
    }
    
    var boundsCenter: CGPoint {
        return CGPoint(x: self.width * 0.5, y: self.height * 0.5)
    }
    
    var size: CGSize {
        get {
            return self.base.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }

}
