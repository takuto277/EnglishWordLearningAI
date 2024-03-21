//
//  InputWordView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/20.
//

import SwiftUI

struct InputWordView: View {
    @Binding var navigationPath: [NavigationPath]
    @State private var text: String = ""
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                TopDesign(title: "単語一覧", height: 250, yOffset: -120)
                
                BottomDesign(height: 150, yOffset: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer().frame(height: geometry.size.height * 0.3)
                Text("入力された単語で英文を作成します。\n単語を入力してください。")
                    .padding()
                    .multilineTextAlignment(.center)
                ZStack(alignment: .topLeading) {
                    textEditor
                    if text.isEmpty {
                        placeholderText
                    }
                }
                .border(Color.black, width: 1)
                .scrollContentBackground(Visibility.hidden)
                .background(Color.textField)
                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.15)
                
                Button {
                    navigationPath.append(.pathSelectSentence)
                } label: {
                    Text("英文作成")
                        .font(.custom("STBaoliTC-Regular", size: 15))
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                }
                .padding()
                .buttonStyle(PositiveButton())
            }
            .padding()
            .frame(width: geometry.size.width)
        }
    }
    
    var placeholderText: some View {
        Text("例: apple")
            .foregroundColor(Color(uiColor: .placeholderText))
            .padding(.vertical, 8)
            .allowsHitTesting(false)
    }
    
    var textEditor: some View {
            TextEditor(text: $text)
                .cornerRadius(10.0)
                .padding(.horizontal, -4)
    }
}

struct InputWordView_Previews: PreviewProvider {
    static var previews: some View {
        @State var navigationPath: [NavigationPath] = []
        InputWordView(navigationPath: $navigationPath)
    }
}
