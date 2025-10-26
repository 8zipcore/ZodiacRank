//
//  ZodiacSign.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/23/25.
//

import Foundation

enum ZodiacSign: Int, CaseIterable {
  case aries, taurus, gemini, cancer, leo, virgo
  case libra, scorpio, sagittarius, capricorn, aquarius, pisces
  
  var name: String {
    switch self {
    case .aries: return "양자리"
    case .taurus: return "황소자리"
    case .gemini: return "쌍둥이자리"
    case .cancer: return "게자리"
    case .leo: return "사자자리"
    case .virgo: return "처녀자리"
    case .libra: return "천칭자리"
    case .scorpio: return "전갈자리"
    case .sagittarius: return "사수자리"
    case .capricorn: return "염소자리"
    case .aquarius: return "물병자리"
    case .pisces: return "물고기자리"
    }
  }
}
