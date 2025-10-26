//
//  ZodiacManager.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/24/25.
//

import SwiftAA
import Foundation

struct ZodiacManager {
  func zodiacRank(for day: Int = Date.now.day) -> [ZodiacSign] {
    let zodiacScores = calculateZodiacScores(for: day)
    let sortedZodiac = sortZodiacScores(from: zodiacScores)
    
    return sortedZodiac.map { $0.value.sign }
  }
  
  private func calculateZodiacScores(for day: Int) -> [ZodiacSign: ZodiacScore] {
    var zodiacScore: [ZodiacSign: ZodiacScore] = Dictionary(uniqueKeysWithValues: ZodiacSign.allCases.map { sign in
      (sign, ZodiacScore(sign: sign))
    })
    
    Planet.allCases.forEach { planet in
      let zodiacSign = planetZodiacSign(for: day, planet: planet)
      let score = PlanetScore.score(for: planet, at: zodiacSign)
      zodiacScore[zodiacSign]?.appendScore(score)
    }
    
    return zodiacScore
  }
  
  private func sortZodiacScores(from zodiacScores: [ZodiacSign : ZodiacScore]) -> [(key: ZodiacSign, value: ZodiacScore)] {
    return zodiacScores.sorted { (lhs: (key: ZodiacSign, value: ZodiacScore),
                                             rhs: (key: ZodiacSign, value: ZodiacScore)) in
      if lhs.value.score != rhs.value.score {
        return lhs.value.score > rhs.value.score
      }
      
      if lhs.value.rulershipCount != rhs.value.rulershipCount {
        return lhs.value.rulershipCount > rhs.value.rulershipCount
      } else if lhs.value.exaltationCount != rhs.value.exaltationCount {
        return lhs.value.exaltationCount > rhs.value.exaltationCount
      } else if lhs.value.detrimentCount != rhs.value.detrimentCount {
        return lhs.value.detrimentCount < rhs.value.detrimentCount
      } else if lhs.value.fallCount != rhs.value.fallCount {
        return lhs.value.fallCount < rhs.value.fallCount
      }
      
      return lhs.key.rawValue < rhs.key.rawValue
    }
  }
  
  private func planetZodiacSign(for day: Int, planet: Planet) -> ZodiacSign {
    let now = JulianDay(Date.makeDate(day: day))
    
    switch planet {
    case .sun:
      let sun = Sun(julianDay: now)
      return zodiacSign(from: sun.eclipticCoordinates.celestialLongitude)
    case .moon:
      let moon = Moon(julianDay: now)
      return zodiacSign(from: moon.eclipticCoordinates.celestialLongitude)
    case .mercury:
      let mercury = Mercury(julianDay: now)
      return zodiacSign(from: mercury.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude)
    case .venus:
      let venus = Venus(julianDay: now)
      return zodiacSign(from: venus.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude)
    case .mars:
      let mars = Mars(julianDay: now)
      return zodiacSign(from: mars.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude)
    case .jupiter:
      let jupiter = Jupiter(julianDay: now)
      return zodiacSign(from: jupiter.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude)
    case .saturn:
      let saturn = Saturn(julianDay: now)
      return zodiacSign(from: saturn.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude)
    }
  }
  
  private func zodiacSign(from longitude: Degree) -> ZodiacSign {
    switch longitude.value {
    case 0..<30: return .aries
    case 30..<60: return .taurus
    case 60..<90: return .gemini
    case 90..<120: return .cancer
    case 120..<150: return .leo
    case 150..<180: return .virgo
    case 180..<210: return .libra
    case 210..<240: return .scorpio
    case 240..<270: return .sagittarius
    case 270..<300: return .capricorn
    case 300..<330: return .aquarius
    case 330..<360: return .pisces
    default: return .aries
    }
  }
}
