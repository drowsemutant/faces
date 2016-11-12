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
    }
    
    enum Eye {
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
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
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
        let eyeCenter = getEyeCenter(eye: eye)
        
        return pathForCirckeCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadiys)
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCirckeCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
    }

}
