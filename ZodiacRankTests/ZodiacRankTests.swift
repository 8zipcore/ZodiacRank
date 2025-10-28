//
//  ZodiacRankTests.swift
//  ZodiacRankTests
//
//  Created by 홍승아 on 10/23/25.
//

import XCTest
@testable import ZodiacRank

final class ZodiacRankTests: XCTestCase {
  
  override func setUpWithError() throws { }
  
  override func tearDownWithError() throws { }
  
  func testSortZodiacScore() {
    let mockZodiacScores: [ZodiacSign: ZodiacScore] = [
      .aries: ZodiacScore(
        sign: .aries,
        score: 4,
        rulershipCount: 1,
        exaltationCount: 1,
        detrimentCount: 1,
        fallCount: 0
      ),
      .taurus: ZodiacScore(
        sign: .taurus,
        score: 1,
        rulershipCount: 1,
        exaltationCount: 0,
        detrimentCount: 0,
        fallCount: 1
      ),
      .gemini: ZodiacScore(
        sign: .gemini,
        score: 5,
        rulershipCount: 1,
        exaltationCount: 0,
        detrimentCount: 0,
        fallCount: 0
      ),
      .cancer: ZodiacScore(
        sign: .cancer,
        score: 4,
        rulershipCount: 0,
        exaltationCount: 1,
        detrimentCount: 0,
        fallCount: 0
      ),
      .leo: ZodiacScore(
        sign: .leo,
        score: 9,
        rulershipCount: 1,
        exaltationCount: 1,
        detrimentCount: 0,
        fallCount: 0
      ),
      .virgo: ZodiacScore(
        sign: .virgo,
        score: 1,
        rulershipCount: 1,
        exaltationCount: 0,
        detrimentCount: 0,
        fallCount: 1
      ),
      .libra: ZodiacScore(
        sign: .libra,
        score: -1,
        rulershipCount: 0,
        exaltationCount: 1,
        detrimentCount: 1,
        fallCount: 0
      ),
      .scorpio: ZodiacScore(
        sign: .scorpio,
        score: 5,
        rulershipCount: 1,
        exaltationCount: 1,
        detrimentCount: 0,
        fallCount: 1
      ),
      .sagittarius: ZodiacScore(
        sign: .sagittarius,
        score: 0,
        rulershipCount: 1,
        exaltationCount: 0,
        detrimentCount: 1,
        fallCount: 0
      ),
      .capricorn: ZodiacScore(
        sign: .capricorn,
        score: 0,
        rulershipCount: 0,
        exaltationCount: 1,
        detrimentCount: 0,
        fallCount: 1
      ),
      .aquarius: ZodiacScore(
        sign: .aquarius,
        score: -4,
        rulershipCount: 1,
        exaltationCount: 0,
        detrimentCount: 1,
        fallCount: 1
      ),
      .pisces: ZodiacScore(
        sign: .pisces,
        score: 4,
        rulershipCount: 0,
        exaltationCount: 1,
        detrimentCount: 0,
        fallCount: 0
      )
    ]
    
    let sortedZodiacRank: [ZodiacSign] = [
      .leo,
      .scorpio,
      .gemini,
      .aries,
      .cancer,
      .pisces,
      .taurus,
      .virgo,
      .sagittarius,
      .capricorn,
      .libra,
      .aquarius
    ]
    
    var zodiacManager = ZodiacManager()
    zodiacManager.zodiacScoresProvider = mockZodiacScores
    
    let zodiacRank = zodiacManager.zodiacRank()
    
    XCTAssertEqual(sortedZodiacRank, zodiacRank)
  }
}
