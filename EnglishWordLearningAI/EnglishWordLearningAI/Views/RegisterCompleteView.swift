//
//  RegisterCompleteView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import SwiftUI

struct RegisterCompleteView<ViewModel: RegisterCompleteViewModel>: View {
    @Binding var navigationPath: [NavigationPath]
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text(viewModel.registerWordData.englishSentence)
                    .font(.custom("STBaoliTC-Regular", size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.registerWordData.japaneseSentence)
                    .font(.custom("STBaoliTC-Regular", size: 15))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ZStack {
                    
                    Circle()
                        .fill(Color.designBackground)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                    
                    // 画像を表示する部分
                    let data = Data(base64Encoded: viewModel.registerWordData.imageString)
                    Image(uiImage: (UIImage(data: data ?? Data()) ?? UIImage(named: "NoImage")) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    
                }
                .padding()
                
                Button {
                    navigationPath.removeAll()
                } label: {
                    Text("ホームに戻る")
                        .font(.custom("STBaoliTC-Regular", size: 15))
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                }
                .padding()
                .buttonStyle(NegativeButton())
            }
        }
    }
}

