//
//  LunarMansionScore.swift
//  ZodiacRank
//
//  Created by 홍승아 on 11/5/25.
//

import Foundation

enum LunarMansionScore: Double {
  case favored = 20
  case unfavored = -15
  
  // 실제 낙샤트라별 행성 지배 + 원소 기반 매핑
  static func favoredSigns(for mansionIndex: Int) -> [ZodiacSign] {
    // 28 Nakshatras 기준 (Ashwini ~ Revati)
    let favoredGroups: [[ZodiacSign]] = [
      // 1. Ashwini (Ketu - 불)
      [.aries, .leo, .sagittarius],
      // 2. Bharani (Venus - 흙)
      [.taurus, .virgo, .capricorn],
      // 3. Krittika (Sun - 불)
      [.aries, .leo, .sagittarius],
      // 4. Rohini (Moon - 물)
      [.cancer, .scorpio, .pisces],
      // 5. Mrigashira (Mars - 불)
      [.aries, .leo, .sagittarius],
      // 6. Ardra (Rahu - 공기)
      [.gemini, .libra, .aquarius],
      // 7. Punarvasu (Jupiter - 불)
      [.aries, .leo, .sagittarius],
      // 8. Pushya (Saturn - 흙)
      [.taurus, .virgo, .capricorn],
      // 9. Ashlesha (Mercury - 공기)
      [.gemini, .libra, .aquarius],
      // 10. Magha (Ketu - 불)
      [.aries, .leo, .sagittarius],
      // 11. Purva Phalguni (Venus - 흙)
      [.taurus, .virgo, .capricorn],
      // 12. Uttara Phalguni (Sun - 불)
      [.aries, .leo, .sagittarius],
      // 13. Hasta (Moon - 물)
      [.cancer, .scorpio, .pisces],
      // 14. Chitra (Mars - 불)
      [.aries, .leo, .sagittarius],
      // 15. Swati (Rahu - 공기)
      [.gemini, .libra, .aquarius],
      // 16. Vishakha (Jupiter - 불)
      [.aries, .leo, .sagittarius],
      // 17. Anuradha (Saturn - 흙)
      [.taurus, .virgo, .capricorn],
      // 18. Jyeshtha (Mercury - 공기)
      [.gemini, .libra, .aquarius],
      // 19. Mula (Ketu - 불)
      [.aries, .leo, .sagittarius],
      // 20. Purva Ashadha (Venus - 흙)
      [.taurus, .virgo, .capricorn],
      // 21. Uttara Ashadha (Sun - 불)
      [.aries, .leo, .sagittarius],
      // 22. Shravana (Moon - 물)
      [.cancer, .scorpio, .pisces],
      // 23. Dhanishta (Mars - 불)
      [.aries, .leo, .sagittarius],
      // 24. Shatabhisha (Rahu - 공기)
      [.gemini, .libra, .aquarius],
      // 25. Purva Bhadrapada (Jupiter - 불)
      [.aries, .leo, .sagittarius],
      // 26. Uttara Bhadrapada (Saturn - 흙)
      [.taurus, .virgo, .capricorn],
      // 27. Revati (Mercury - 공기)
      [.gemini, .libra, .aquarius],
      // 28. 보정용 (Cycle 반복)
      [.cancer, .scorpio, .pisces]
    ]
    
    return favoredGroups[mansionIndex]
  }
  
  static func unfavoredSigns(for mansionIndex: Int) -> [ZodiacSign] {
    // 반대 원소 기반 상극 관계
    let unfavoredGroups: [[ZodiacSign]] = [
      [.cancer, .capricorn],
      [.aries, .libra],
      [.taurus, .scorpio],
      [.leo, .aquarius],
      [.cancer, .capricorn],
      [.taurus, .scorpio],
      [.virgo, .pisces],
      [.gemini, .sagittarius],
      [.aries, .libra],
      [.taurus, .scorpio],
      [.cancer, .capricorn],
      [.pisces, .virgo],
      [.leo, .aquarius],
      [.cancer, .capricorn],
      [.taurus, .scorpio],
      [.aries, .libra],
      [.gemini, .sagittarius],
      [.leo, .aquarius],
      [.cancer, .capricorn],
      [.pisces, .virgo],
      [.gemini, .sagittarius],
      [.leo, .aquarius],
      [.taurus, .scorpio],
      [.virgo, .pisces],
      [.aries, .libra],
      [.cancer, .capricorn],
      [.taurus, .scorpio],
      [.leo, .aquarius]
    ]
    
    return unfavoredGroups[mansionIndex]
  }
}
