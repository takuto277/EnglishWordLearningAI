//
//  InputWordView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/20.
//

import SwiftUI
import SVProgressHUD

struct InputWordView<ViewModel: InputWordViewModel>: View {
    @Binding var navigationPath: [NavigationPath]
    @ObservedObject var viewModel: ViewModel
    @State private var text: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                // TODO　入力された単語で英文を作成します。\n単語を入力してください。
                Text("登録したい文章を翻訳します。\n日本語で文章を入力してください。")
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
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("戻る")
                            .font(.custom("STBaoliTC-Regular", size: 15))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                    }
                    .padding()
                    .buttonStyle(NegativeButton())
                    
                    Button {
                        SVProgressHUD.show()
                        viewModel.getNewWordData(text: self.text) { newWordData in
                            SVProgressHUD.dismiss()
                            if let newWordData = newWordData {
                                navigationPath.append(.pathSelectSentence(newWordData))
                            } else {
                                showAlert = true
                            }
                        }
                    } label: {
                        Text("英文作成")
                            .font(.custom("STBaoliTC-Regular", size: 15))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                    }
                    .padding()
                    .buttonStyle(PositiveButton())
                    .disabled(self.text.isEmpty)
                    .opacity(self.text.isEmpty ? 0.5 : 1.0)
                }
            }
            .padding()
            .frame(width: geometry.size.width)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("注意"),
                    message: Text("翻訳に失敗しました。\nやり直してください。"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    var placeholderText: some View {
        Text("例: りんご")
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
    @Environment(\.dismiss) var dismiss
    static var previews: some View {
        @State var navigationPath: [NavigationPath] = []
        InputWordView(navigationPath: $navigationPath, viewModel: InputWordViewModel())
    }
}
