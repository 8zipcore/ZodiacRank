//
//  ZodiacManager.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/24/25.
//

import SwiftAA
import Foundation

struct ZodiacManager {
  typealias ZodiacScoreMap = [ZodiacSign: ZodiacScore]
    
  var zodiacScoresProvider: ZodiacScoreMap?
  
  func zodiacRank(for day: Int = Date.now.day) -> [ZodiacSign] {
    let planetScores = calculatePlanetScores(for: day)
    let angleScores = calculateAngleScores(for: day)
    let houseScores = calculateHouseScores(for: day)
    let mansionScores = calculateLunarMansionScores(for: day)
    let moonPhaseScores = calculateMoonPhaseScores(for: day)
    
    let totalScore = calculateTotalScore(
      planetScores: planetScores,
      angleScores: angleScores,
      houseScores: houseScores,
      mansionScores: mansionScores,
      moonPhaseScores: moonPhaseScores
    )
    let sortedZodiac = sortZodiacScores(from: totalScore)
    
    sortedZodiac.forEach {
      print($0.key.name, $0.value.score)
    }

    return sortedZodiac.map { $0.value.sign }
  }
  
  private func initialZodiacScores() -> ZodiacScoreMap {
    Dictionary(uniqueKeysWithValues: ZodiacSign.allCases.map { sign in
      (sign, ZodiacScore(sign: sign))
    })
  }
  
  private func calculateTotalScore(
    planetScores: ZodiacScoreMap,
    angleScores: ZodiacScoreMap,
    houseScores: ZodiacScoreMap,
    mansionScores: ZodiacScoreMap,
    moonPhaseScores: ZodiacScoreMap,
  ) -> ZodiacScoreMap {
    var totalScore: ZodiacScoreMap = [:]
    
    // 최종 점수 공식의 가중치
    let planetWeight: Double = 0.35
    let angleWeight: Double = 0.10
    let houseWeight: Double = 0.05
    let mansionWeight: Double = 0.20
    let moonPhaseWeight: Double = 0.10
    
    ZodiacSign.allCases.forEach { zodiacSign in
      let planetScore = planetScores[zodiacSign]?.score ?? 0
      let angleScore = angleScores[zodiacSign]?.score ?? 0
      let houseScore = houseScores[zodiacSign]?.score ?? 0
      let mansionScore = mansionScores[zodiacSign]?.score ?? 0
      let moonPhaseScore = moonPhaseScores[zodiacSign]?.score ?? 0
      
      let weightedPlanet = planetScore * planetWeight
      let weightedAngle = angleScore * angleWeight
      let weightedHouse = houseScore * houseWeight
      let weightedMansion = mansionScore * mansionWeight
      let weightedMoonPhase = moonPhaseScore * moonPhaseWeight
      
      let finalScore = weightedPlanet + weightedAngle + weightedHouse +
                       weightedMansion + weightedMoonPhase
      
      if var zodiacScore = planetScores[zodiacSign] {
        zodiacScore.score = finalScore
        totalScore[zodiacSign] = zodiacScore
      }
    }
    
    return totalScore
  }
}

// MARK: - 행성 위치별 계산
extension ZodiacManager {
  private func calculatePlanetScores(for day: Int) -> ZodiacScoreMap {
    if let mock = zodiacScoresProvider {
      return mock
    }
    
    var zodiacScore = initialZodiacScores()
    
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
  private func calculateAngleScores(for day: Int) -> ZodiacScoreMap {
    var zodiacScore = initialZodiacScores()
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

// MARK: - 하우스 점수 계산
extension ZodiacManager {
  private func calculateHouseScores(for day: Int) -> ZodiacScoreMap {
    var zodiacScore = initialZodiacScores()
    let sunLongtitude = planetLongtitude(for: day, planet: .sun)
    let sunZodiacSign = zodiacSign(from: sunLongtitude)
    
    ZodiacSign.allCases.forEach { zodiacSign in
      let score = HouseScore.score(sunZodiacSign: sunZodiacSign, zodiacSign: zodiacSign)
      zodiacScore[zodiacSign]?.appendScore(score)
    }
    
    return zodiacScore
  }
}

// MARK: - 달의 Lunar Mansion 계산
extension ZodiacManager {
  private func calculateLunarMansionScores(for day: Int) -> ZodiacScoreMap {
    var zodiacScore = initialZodiacScores()
    let moonLongitude = planetLongtitude(for: day, planet: .moon)
    
    // 28 lunar mansions (Nakshatras) - 각각 약 12.857도
    let degreesPerLunarMansion: Double = 360.0 / 28.0
    let mansionIndex = Int(moonLongitude.value / degreesPerLunarMansion) % 28
    
    let favoredSigns = LunarMansionScore.favoredSigns(for: mansionIndex)
    let unfavoredSigns = LunarMansionScore.unfavoredSigns(for: mansionIndex)
    
    favoredSigns.forEach { sign in
      zodiacScore[sign]?.appendScore(.favored)
    }
    
    unfavoredSigns.forEach { sign in
      zodiacScore[sign]?.appendScore(.unfavored)
    }
    
    return zodiacScore
  }
}

// MARK: - 달의 위상 계산
extension ZodiacManager {
  private func calculateMoonPhaseScores(for day: Int) -> ZodiacScoreMap {
    var zodiacScore = initialZodiacScores()
    let moonLongitude = planetLongtitude(for: day, planet: .moon)
    let sunLongitude = planetLongtitude(for: day, planet: .sun)
    
    // 달과 태양 사이의 각도 차이 (0°~360°)
    let phaseDegree = (moonLongitude.value - sunLongitude.value + 360).truncatingRemainder(dividingBy: 360)
    
    // 위상별 강화 원소
    let favoredElements: [ZodiacElement]
    switch phaseDegree {
    case 0..<45:   // 🌑 신월 - 시작, 의지, 불의 에너지
      favoredElements = [.fire]
    case 45..<90:  // 🌒 초승달 - 성장, 안정, 흙의 에너지
      favoredElements = [.earth]
    case 90..<135: // 🌓 상현달 - 소통, 사고, 공기의 에너지
      favoredElements = [.air]
    case 135..<225: // 🌕 보름달 - 감정, 관계, 물의 에너지
      favoredElements = [.water]
    case 225..<270: // 🌗 하현달 - 정리, 구조화, 흙의 에너지
      favoredElements = [.earth]
    default: // 🌘 그믐달 - 내면, 휴식, 물의 에너지
      favoredElements = [.water]
    }
    
    // 점수 배분
    for sign in ZodiacSign.allCases {
      if favoredElements.contains(sign.element) {
        zodiacScore[sign]?.appendScore(.beneficial)
      } else {
        zodiacScore[sign]?.appendScore(.detrimental)
      }
    }
    
    return zodiacScore
  }
}
