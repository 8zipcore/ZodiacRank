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
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
    
    var comps = DateComponents()
    comps.year = year
    comps.month = month
    comps.day = day
    comps.hour = 0
    comps.minute = 0
    
    /*
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    print(formatter.string(from: calendar.date(from: comps)!))
    */
    
    return calendar.date(from: comps) ?? .now
  }
}
