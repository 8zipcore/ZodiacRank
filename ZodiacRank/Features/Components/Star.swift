//
//  Star.swift
//  ZodiacRank
//
//  Created by 홍승아 on 11/11/25.
//

import SwiftUI

struct Star: Shape {
  let points: Int = 5
  
  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let angle = .pi * 2 / Double(points * 2)
    
    var path = Path()
    var currentAngle = -Double.pi / 2
    
    var firstPoint: CGPoint?
    
    for i in 0..<(points * 2) {
      let length = i.isMultiple(of: 2) ? radius : radius / 2.5
      let point = CGPoint(
        x: center.x + CGFloat(cos(currentAngle)) * length,
        y: center.y + CGFloat(sin(currentAngle)) * length
      )
      if i == 0 {
        path.move(to: point)
        firstPoint = point
      } else {
        path.addLine(to: point)
      }
      currentAngle += angle
    }
    
    if let firstPoint {
      path.addLine(to: firstPoint)
    }
    
    return path
  }
}
