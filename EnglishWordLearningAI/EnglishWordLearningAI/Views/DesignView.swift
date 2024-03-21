//
//  DesignView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/20.
//

import SwiftUI

struct TopDesign: View {
    let title: String
    let height: CGFloat
    let yOffset: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.designBackground)
                .frame(height: height)
                .offset(y: yOffset)
            // 半円形
            Ellipse()
                .foregroundColor(Color.designBackground)
                .frame(height: 70) // 半円の直径と高さ
                .offset(y: 0)
            
            Text(title)
                     .foregroundColor(.black)
                     .font(.title)
                     .fontWeight(.bold)
                     .padding(.top, -50)
        }
    }
}

struct BottomDesign: View {
    let height: CGFloat
    let yOffset: CGFloat
    
    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(Color.designBackground)
                .frame(height: 100)
                .offset(y: yOffset * 0.91)
            
            Rectangle()
                .fill(Color.designBackground)
                .frame(height: height)
                .offset(y: yOffset)
        }
    }
}

struct PositiveButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.positivePush : Color.positive)
            .foregroundStyle( .white)
            .cornerRadius(30)
    }
}

struct NegativeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.negativePush : Color.negative)
            .foregroundStyle( .white)
            .cornerRadius(30)
    }
}
