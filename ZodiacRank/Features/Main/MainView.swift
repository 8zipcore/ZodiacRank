//
//  MainView.swift
//  ZodiacRank
//
//  Created by 홍승아 on 10/20/25.
//

import SwiftUI

struct MainView: View {
  
  private let horizontalPadding: CGFloat = 20
  private let ellipseYOffset: CGFloat = 35
  
  private var blueCircle: some View {
    Circle()
      .foregroundStyle(.pointBlue)
      .frame(width: 30)
  }
  
  var body: some View {
    ZStack {
      VStack {
        dateSeciton()
        
        Spacer()
        
        titleSection()
      }
      
      zodiacRankSection()
    }
    .padding(.horizontal, horizontalPadding)
    .background(elipseBackground())
  }
}

extension MainView {
  @ViewBuilder
  private func dateSeciton() -> some View {
    HStack(spacing: 15) {
      Text("8")
        .font(.unbounded(size: 100))
        .foregroundStyle(.black)
        .overlay {
          HStack {
            Spacer()
            
            VStack {
              blueCircle
              
              Spacer()
            }
          }
          .offset(x: 5, y: 10)
        }
      
      Text("12")
        .font(.unbounded(size: 60))
        .foregroundStyle(.black)
        .offset(y: -13)
        .overlay {
          HStack {
            Spacer()
            
            VStack {
              Spacer()
              
              blueCircle
            }
          }
          .offset(y: -2)
        }
      
      Spacer()
    }
  }
  
  @ViewBuilder
  private func titleSection() -> some View {
    let fontSize: CGFloat = 55
    
    HStack {
      Spacer()
      
      VStack(alignment: .trailing, spacing: -10) {
        Text("별자리")
          .font(.notoSansKR(size: fontSize))
          .foregroundStyle(.black)
          .background(
            HStack {
              Spacer()
              
              VStack {
                blueCircle
                
                Spacer()
              }
            }
              .offset(x: 10)
          )
        
        Text("운세")
          .font(.notoSansKR(size: fontSize))
          .foregroundStyle(.black)
          .background(
            HStack {
              VStack {
                blueCircle
                
                Spacer()
              }
              
              Spacer()
            }
            .offset(x: -9, y: 3)
          )
      }
    }
  }
  
  @ViewBuilder
  private func zodiacRankSection() -> some View {
    let zodiacRank: [ZodiacSign] = [
      .aries, .taurus, .gemini, .cancer, .leo, .virgo, .libra, .scorpio, .sagittarius, .capricorn, .aquarius, .pisces
    ]
    
    VStack(spacing: 5) {
      ForEach(zodiacRank.indices, id: \.self) { index in
        let zodiacSign = zodiacRank[index]
        let ranking = String(format: "%02d", index + 1)
        
        HStack {
          Text("\(ranking)           \(zodiacSign.name) ")
            .font(.notoSansKR(size: 22))
            .foregroundStyle(.black)
          
          Spacer()
        }
      }
    }
    .padding(.top, ellipseYOffset)
    .padding(.horizontal, 20)
  }
  
  private func starYOffset(ellipseSize: CGSize, cutWidth: CGFloat) -> CGFloat {
    let a = ellipseSize.width / 2
    let b = ellipseSize.height / 2
    let x = cutWidth / 2

    let y = b * sqrt(1 - (x * x) / (a * a)) * 2
    
    return (ellipseSize.height - y) / 2
  }
  
  @ViewBuilder
  private func elipseBackground() -> some View {
    let bigStar = Star()
      .foregroundStyle(.white)
      .frame(width: 20, height: 20)
      .rotationEffect(.degrees(45))
    let smallStar = Star()
      .foregroundStyle(.white)
      .frame(width: 15, height: 15)
      .rotationEffect(.degrees(45))
    
    Color.skyBlue
      .overlay {
        GeometryReader { geometry in
          let ellipseWidth = geometry.size.width * 1.8
          let ellipseHeight = ellipseWidth * 0.8
          let ellipseXOffset = -(ellipseWidth - geometry.size.width) / 2
          
          let starYOffset = starYOffset(
            ellipseSize: CGSize(
              width: ellipseWidth,
              height: ellipseHeight
            ),
            cutWidth: geometry.size.width
          ) / 2
          
          VStack(spacing: .zero) {
            HStack(alignment: .bottom, spacing: 10) {
              Spacer()
              
              smallStar
                .offset(y: -10)
              
              VStack {
                Spacer()
                
                bigStar
              }
            }
            .padding(.horizontal, 10)
            .offset(y: starYOffset)
            
            Ellipse()
              .foregroundStyle(.white)
              .frame(width: ellipseWidth, height: ellipseHeight)
            
            HStack(alignment: .top, spacing: 10) {
              VStack {
                bigStar
                
                Spacer()
              }
              
              smallStar
                .offset(y: 10)
                
              Spacer()
            }
            .padding(.horizontal, 10)
            .offset(y: -starYOffset)
          }
          .offset(x: ellipseXOffset, y: ellipseYOffset)
        }
      }
      .ignoresSafeArea()
  }
}

#Preview {
  MainView()
}
