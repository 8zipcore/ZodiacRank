//
//  HouseScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/31/25.
//

import Foundation

enum HouseScore: Int {
  case selfVitality
  case resourcesFinance
  case communicationLearning
  case homeFamily
  case loveCreativity
  case workHealth
  case relationshipsPartners
  case crisisTransformation
  case expansionWisdom
  case careerPublicStatus
  case friendsHopes
  case isolationClosure
  
  var value: Double {
    switch self {
    case .loveCreativity, .expansionWisdom:
      return 2
    case .workHealth, .crisisTransformation, .isolationClosure:
      return -2
    default:
      return 0
    }
  }
  
  static func score(sunZodiacSign: ZodiacSign, zodiacSign: ZodiacSign) -> HouseScore {
    let houseRawValue = (zodiacSign.rawValue - sunZodiacSign.rawValue + 12) % 12
  
    return HouseScore(rawValue: houseRawValue) ?? .selfVitality
  }
}
