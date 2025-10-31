//
//  AngleScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/28/25.
//

import SwiftAA

enum AngleScore: Double, CaseIterable {
  case trine = 3
  case sextile = 2
  case square = -3
  case opposition = -2
  case none = 0
  
  var centerAngle: Int {
    switch self {
    case .trine: return 120
    case .sextile: return 60
    case .square: return 90
    case .opposition: return 180
    case .none: return 0
    }
  }
  
  static func score(moonLongtitude: Degree, planetLongtitude: Degree) -> AngleScore {
    let orb = 3
    let angleDifference = Int(abs(moonLongtitude.value - planetLongtitude.value))
    
    for aspect in AngleScore.allCases {
      guard aspect != .none else { continue }
      
      let range = (aspect.centerAngle - orb)...(aspect.centerAngle + orb)
      if range.contains(angleDifference) {
        return aspect
      }
    }
    
    return .none
  }
}
