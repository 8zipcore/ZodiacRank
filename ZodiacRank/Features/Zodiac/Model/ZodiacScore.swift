//
//  ZodiacScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/27/25.
//

import Foundation

struct ZodiacScore {
  let sign: ZodiacSign
  var score: Double = 0
  // 동점 처리 / 통계용
  var rulershipCount: Int = 0
  var exaltationCount: Int = 0
  var detrimentCount: Int = 0
  var fallCount: Int = 0
  
  mutating func appendScore(planet: Planet, _ planetScore: PlanetScore) {
    let isMoon = planet == .moon
    // 달은 가중치 적용
    score += isMoon ? planetScore.rawValue * 2 : planetScore.rawValue
    
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
  
  mutating func appendScore(_ angleScore: AngleScore) {
    score += angleScore.rawValue
  }
  
  mutating func appendScore(_ houseScore: HouseScore) {
    score += houseScore.value
  }
  
  mutating func appendScore(_ lunarMansionScore: LunarMansionScore) {
    self.score += lunarMansionScore.rawValue
  }
}
