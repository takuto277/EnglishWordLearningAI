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
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Image("topDesign")
                .resizable()
                .frame(width: width, height: height)
            
            Text(title)
                     .foregroundColor(.black)
                     .font(.title)
                     .fontWeight(.bold)
                     .padding(.top)
        }
    }
}

struct BottomDesign: View {
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Image("bottomDesign")
                .resizable()
                .frame(width: width, height: height)
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
