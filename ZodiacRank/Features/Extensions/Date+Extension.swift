//
//  Date+Extension.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/24/25.
//

import Foundation

extension Date {
  static func makeDate(
    year: Int = Date.now.year,
    month: Int = Date.now.month,
    day: Int
  ) -> Date {
    var comps = DateComponents()
    comps.year = year
    comps.month = month
    comps.day = day
    
    return Calendar.current.date(from: comps) ?? .now
  }
}
