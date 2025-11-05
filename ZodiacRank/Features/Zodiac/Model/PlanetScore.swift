//
//  PlanetScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/27/25.
//

import Foundation

enum PlanetScore: Double {
  case rulership = 5
  case exaltation = 4
  case detriment = -5
  case fall = -4
  case none = 0
  
  static func score(for planet: Planet, at sign: ZodiacSign) -> PlanetScore {
    switch planet {
    case .sun:
      switch sign {
      case .leo: return .rulership
      case .aries: return .exaltation
      case .aquarius: return .detriment
      case .libra: return .fall
      default: return .none
      }
    case .moon:
      switch sign {
      case .cancer: return .rulership
      case .taurus: return .exaltation
      case .capricorn: return .detriment
      case .scorpio: return .fall
      default: return .none
      }
    case .mercury:
      switch sign {
      case .gemini, .virgo: return .rulership
      case .sagittarius, .pisces: return .detriment
      case .aquarius: return .fall
      default: return .none
      }
    case .venus:
      switch sign {
      case .taurus, .libra: return .rulership
      case .pisces: return .exaltation
      case .scorpio, .aries: return .detriment
      case .virgo: return .fall
      default: return .none
      }
    case .mars:
      switch sign {
      case .aries, .scorpio: return .rulership
      case .capricorn: return .exaltation
      case .libra, .taurus: return .detriment
      case .cancer: return .fall
      default: return .none
      }
    case .jupiter:
      switch sign {
      case .sagittarius, .pisces: return .rulership
      case .cancer: return .exaltation
      case .gemini, .virgo: return .detriment
      case .capricorn: return .fall
      default: return .none
      }
    case .saturn:
      switch sign {
      case .capricorn, .aquarius: return .rulership
      case .libra: return .exaltation
      case .cancer, .leo: return .detriment
      case .aries: return .fall
      default: return .none
      }
    }
  }
  
  static func rulerships(for planet: Planet) -> [ZodiacSign] {
    switch planet {
    case .sun:
      return [.leo]
    case .moon:
      return [.cancer]
    case .mercury:
      return [.gemini, .virgo]
    case .venus:
      return [.taurus, .libra]
    case .mars:
      return [.aries, .scorpio]
    case .jupiter:
      return [.sagittarius, .pisces]
    case .saturn:
      return [.capricorn, .aquarius]
    }
  }
}
