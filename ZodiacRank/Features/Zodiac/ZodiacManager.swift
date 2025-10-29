//
//  ZodiacManager.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/24/25.
//

import SwiftAA
import Foundation

struct ZodiacManager {
  var zodiacScoresProvider: [ZodiacSign: ZodiacScore]?
  
  func zodiacRank(for day: Int = Date.now.day) -> [ZodiacSign] {
    let planetScores = calculatePlanetScores(for: day)
    let angleScores = calculateAngleScores(for: day)
    let totalScores =  Dictionary(
      uniqueKeysWithValues: planetScores.map { score in
        let zodiacSign = score.key
        var newScore = score
        newScore.value.score += angleScores[zodiacSign]?.score ?? 0
        
        return newScore
      }
    )
    let sortedZodiac = sortZodiacScores(from: totalScores)

    return sortedZodiac.map { $0.value.sign }
  }
  
  private func initialZodiacScores() -> [ZodiacSign: ZodiacScore] {
    Dictionary(uniqueKeysWithValues: ZodiacSign.allCases.map { sign in
      (sign, ZodiacScore(sign: sign))
    })
  }
}

// MARK: - 행성 위치별 계산
extension ZodiacManager {
  private func calculatePlanetScores(for day: Int) -> [ZodiacSign: ZodiacScore] {
    if let mock = zodiacScoresProvider {
      return mock
    }
    
    var zodiacScore: [ZodiacSign: ZodiacScore] = initialZodiacScores()
    
    Planet.allCases.forEach { planet in
      let longtitude = planetLongtitude(for: day, planet: planet)
      let zodiacSign = zodiacSign(from: longtitude)
      let score = PlanetScore.score(for: planet, at: zodiacSign)
      zodiacScore[zodiacSign]?.appendScore(planet: planet, score)
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
  
  private func planetLongtitude(for day: Int, planet: Planet) -> Degree {
    let now = JulianDay(Date.makeDate(day: day))
    
    switch planet {
    case .sun:
      let sun = Sun(julianDay: now)
      return sun.eclipticCoordinates.celestialLongitude
    case .moon:
      let moon = Moon(julianDay: now)
      return moon.eclipticCoordinates.celestialLongitude
    case .mercury:
      let mercury = Mercury(julianDay: now)
      return mercury.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude
    case .venus:
      let venus = Venus(julianDay: now)
      return venus.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude
    case .mars:
      let mars = Mars(julianDay: now)
      return mars.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude
    case .jupiter:
      let jupiter = Jupiter(julianDay: now)
      return jupiter.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude
    case .saturn:
      let saturn = Saturn(julianDay: now)
      return saturn.equatorialCoordinates.makeEclipticCoordinates().celestialLongitude
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

// MARK: - 달과 다른 행성들 간의 각도 계산
extension ZodiacManager {
  private func calculateAngleScores(for day: Int) -> [ZodiacSign: ZodiacScore] {
    var zodiacScore: [ZodiacSign: ZodiacScore] = initialZodiacScores()
    let moonLongtitude = planetLongtitude(for: day, planet: .moon)
    
    Planet.allCases.forEach { planet in
      guard planet != .moon else { return }
      let longtitude = planetLongtitude(for: day, planet: planet)
      let zodiacSign = zodiacSign(from: longtitude)
      let score = AngleScore.score(moonLongtitude: moonLongtitude, planetLongtitude: longtitude)
      zodiacScore[zodiacSign]?.appendScore(score)
    }
    
    return zodiacScore
  }
}
