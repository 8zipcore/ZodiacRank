//
//  ZodiacScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/27/25.
//

import Foundation

struct ZodiacScore {
  let sign: ZodiacSign
  var score: Int = 0
  // 동점 처리 / 통계용
  var rulershipCount: Int = 0
  var exaltationCount: Int = 0
  var detrimentCount: Int = 0
  var fallCount: Int = 0
  
  mutating func appendScore(_ planetScore: PlanetScore) {
    score += planetScore.rawValue
    
    switch planetScore {
    case .rulership:
      rulershipCount += 1
    case .exaltation:
      exaltationCount += 1
    case .detriment:
      detrimentCount += 1
    case .fall:
      fallCount += 1
    case .none:
      break
    }
  }
}
