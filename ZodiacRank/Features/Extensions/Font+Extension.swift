//
//  Font+Extension.swift
//  ZodiacRank
//
//  Created by 홍승아 on 11/12/25.
//

import SwiftUI

extension Font {
  static func notoSansKR(size: CGFloat) -> Font {
    Font.custom("NotoSansKR-Bold", size: size)
  }
  
  static func unbounded(size: CGFloat) -> Font {
    Font.custom("Unbounded-ExtraBold", size: size)
  }
}
