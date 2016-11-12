//
//  Face.swift
//  Faces
//
//  Created by Sergey Lapshin on 08.11.16.
//  Copyright © 2016 Sergey Lapshin. All rights reserved.
//

import UIKit

class Face: UIView {
    
    var scale: CGFloat = 0.90
    let mouthCurvature = 1.0
    var eyesOpen: Bool = true
    var eyeBrowTilt: Double = 0.0
    
    var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratio {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCirckeCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
         let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false)
        
        path.lineWidth = 5.0
        return path
    }
    
    private func getEyeCenter(_ eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratio.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadiys = skullRadius / Ratio.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        
        if eyesOpen {
        return pathForCirckeCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadiys)
        } else {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadiys, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadiys, y: eyeCenter.y))
            path.lineWidth = 5.0
            return path
        }
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath {
        var tilt = eyeBrowTilt
        
        switch eye {
        case .Left:
            tilt *= -1.0
        case .Right:
            break;
        }
        
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Ratio.SkullRadiusToBrowOffset
        
        let eyeRadius = skullRadius / Ratio.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1,min(tilt,1))) * eyeRadius/2
        
        let browstart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        
        path.move(to: browstart)
        path.addLine(to: browEnd)
        path.lineWidth = 5.0
        
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratio.SkullRadiusToMouthWidth
        let mouthHeigth = skullRadius / Ratio.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratio.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeigth)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width/3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width/3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCirckeCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        
        pathForMouth().stroke()
        
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }

}
