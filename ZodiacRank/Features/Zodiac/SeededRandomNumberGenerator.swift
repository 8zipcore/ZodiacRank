//
//  SeededRandomNumberGenerator.swift
//  ZodiacRank
//
//  Created by 홍승아 on 11/5/25.
//

import Foundation

struct SeededRandomNumberGenerator: RandomNumberGenerator {
  private var state: UInt64
  
  init(seed: UInt64) {
    state = seed
  }
  
  mutating func next() -> UInt64 {
    state = state &* 6364136223846793005 &+ 1442695040888963407
    return state
  }
}
