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
    
    //let skullRadius = min(bounds.size.width, bounds.size.height)/2
    var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    //let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    override func draw(_ rect: CGRect) {
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
        
        skull.lineWidth = 5.0
        UIColor.blue.set()
        skull.stroke()
        
    
    }

}
