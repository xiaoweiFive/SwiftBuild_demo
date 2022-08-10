//
//  MMSScrollLabel-CAMediaTiming.swift
//  MMSUIBaseFoundation
//
//  Created by YinYuGuang on 2021/7/20.
//

import Foundation

extension CAMediaTimingFunction {
    func durationPercentageForPositionPercentage(_ positionPercentage: CGFloat, duration: CGFloat) -> CGFloat {
        let controlPoints = self.controlPoints()
        let epsilon: CGFloat = 1.0 / (100.0 * CGFloat(duration))
        let tFound = solveTforY(positionPercentage, epsilon: epsilon, controlPoints: controlPoints)
        let durationPercentage = xforCurveAt(tFound, controlPoints: controlPoints)
        return durationPercentage
    }
    
    func solveTforY(_ y0: CGFloat, epsilon: CGFloat, controlPoints: [CGPoint]) -> CGFloat {
        var t0 = y0
        var t1 = y0
        
        var f0: CGFloat
        var df0: CGFloat
        
        for _ in 0..<15 {
            t0 = t1
            f0 = yforCurveAt(t0, controlPoints) - y0
            if abs(f0) < epsilon {
                return t0
            }
            df0 = derivativeCurveYValueAt(t0, controlPoints)
            if abs(df0) < 1e-6 {
                break
            }
            t1 = t0 - f0/df0
        }
        return t0
    }
    
    func yforCurveAt(_ t: CGFloat, _ controlPoints: [CGPoint]) -> CGFloat {
        let p0 = controlPoints[0]
        let p1 = controlPoints[1]
        let p2 = controlPoints[2]
        let p3 = controlPoints[3]
        
        let y0 = (pow((1.0 - t), 3.0) * p0.y)
        let y1 = (3.0 * pow(1.0 - t, 2.0) * t * p1.y)
        let y2 = (3.0 * (1.0 - t) * pow(t, 2.0) * p2.y)
        let y3 = (pow(t, 3.0) * p3.y)
        
        return y0 + y1 + y2 + y3
    }
    
    func xforCurveAt(_ t: CGFloat, controlPoints: [CGPoint]) -> CGFloat {
        let p0 = controlPoints[0]
        let p1 = controlPoints[1]
        let p2 = controlPoints[2]
        let p3 = controlPoints[3]

        let x0 = (pow((1.0 - t), 3.0) * p0.x)
        let x1 = (3.0 * pow(1.0 - t, 2.0) * t * p1.x)
        let x2 = (3.0 * (1.0 - t) * pow(t, 2.0) * p2.x)
        let x3 = (pow(t, 3.0) * p3.x)
        
        return x0 + x1 + x2 + x3
    }
    
    func derivativeCurveYValueAt(_ t: CGFloat, _ controlPoints: [CGPoint]) -> CGFloat {
        let p0 = controlPoints[0]
        let p1 = controlPoints[1]
        let p2 = controlPoints[2]
        let p3 = controlPoints[3]
        
        let dy0 = (p0.y + 3.0 * p1.y + 3.0 * p2.y - p3.y) * -3.0
        let dy1 = t * (6.0 * p0.y + 6.0 * p2.y)
        let dy2 = (-3.0 * p0.y + 3.0 * p1.y)

        return dy0 * pow(t, 2.0) + dy1 + dy2
    }
    
    func controlPoints() -> [CGPoint] {
        var point: [Float] = [0.0, 0.0]
        var pointArray = [CGPoint]()
        for i in 0...3 {
            getControlPoint(at: i, values: &point)
            pointArray.append(CGPoint(x: CGFloat(point[0]), y: CGFloat(point[1])))
        }
        return pointArray
    }
}

