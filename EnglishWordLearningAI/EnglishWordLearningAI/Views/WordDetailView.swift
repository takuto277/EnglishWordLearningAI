//
//  WordDetailView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import SwiftUI

struct WordDetailView<ViewModel: WordDetailViewModel>: View {
    @Binding var navigationPath: [NavigationPath]
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                // 画像を表示する部分
                let data = Data(base64Encoded: viewModel.registerWordData.imageString)
                Image(uiImage: (UIImage(data: data ?? Data()) ?? UIImage(named: "NoImage")) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                
                Text(viewModel.registerWordData.englishSentence)
                    .padding()
                    .font(.custom("STBaoliTC-Regular", size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.registerWordData.japaneseSentence)
                    .font(.custom("STBaoliTC-Regular", size: 15))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                Button {
                    viewModel.startSound()
                } label: {
                    Image(systemName: "speaker.3.fill")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .frame(width: geometry.size.width / 10)
                
                Spacer()
                
                Button {
                    navigationPath.removeAll()
                } label: {
                    Text("ホームに戻る")
                        .font(.custom("STBaoliTC-Regular", size: 15))
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                }
                .padding()
                .buttonStyle(NegativeButton())
                
                Spacer()
            }
        }
    }
}
