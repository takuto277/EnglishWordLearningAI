//
//  SelectSentenceView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/21.
//

import SwiftUI

struct SelectSentenceView<ViewModel: SelectSentenceViewModel>: View {
    @Binding var navigationPath: [NavigationPath]
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            // 単語名履歴
            VStack {
                Text("単語名:\(viewModel.newWordData.englishWord), \(viewModel.newWordData.japansesWord)")
                    .padding()
                    .multilineTextAlignment(.leading)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.05)
                    .background(Color.selectWordBackground)
                    .cornerRadius(30)
                
                // 文章リスト
                List {
                    ForEach(Array(viewModel.newWordData.response.enumerated()), id: \.1) { index, element in
                        Button {
                            viewModel.setSentenceNumber(number: index)
                        } label: {
                            Text(element.englishSentence)
                                .font(.custom("STBaoliTC-Regular", size: 15))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(element.japaneseSentence)
                                .font(.custom("STBaoliTC-Regular", size: 10))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(viewModel.getSelectedSentenceNumber() == index ? Color.positivePush : Color.clear)
                    }
                }
                
                // 選択ボタン
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
                        // TODO: 選択した文章を用いてイメージ画像作成呼び出し
                        // TODO: その後に遷移: navigationPath.append(.pathSelectImage)
                        SVProgressHUD.show()
                        viewModel.getNewImageData { newImageData in
                            SVProgressHUD.dismiss()
                            navigationPath.append(.pathSelectImage(newImageData))
                        }
                    } label: {
                        Text("決定")
                            .font(.custom("STBaoliTC-Regular", size: 15))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                    }
                    .padding()
                    .buttonStyle(PositiveButton())
                }
                Spacer().frame(height: 50)
            }
            .padding()
            .frame(width: geometry.size.width)
        }
    }
}

struct SelectSentenceView_Previews: PreviewProvider {
    @Environment(\.dismiss) var dismiss
    static let previewNewWordData: NewWordData = NewWordData(
        englishWord: "apple",
        japansesWord: "りんご",
        response: [
            SentenceResponse(englishSentence: "I have a apple.", japaneseSentence: "私はりんごを持っています。"),
            SentenceResponse(englishSentence:"There is a apple.", japaneseSentence: "りんごがあります。"),
            SentenceResponse(englishSentence: "Why don't you eat apple.", japaneseSentence: "りんごはいかがですか。"),
            SentenceResponse(englishSentence: "I don't have a apple.", japaneseSentence: "私はりんごを持っていません。"),
            SentenceResponse(englishSentence:"There is not a apple.", japaneseSentence: "りんごがありません。"),
            SentenceResponse(englishSentence: "Why don't you see apple.", japaneseSentence: "りんごはいかがですか。"),
            SentenceResponse(englishSentence: "I have two apple.", japaneseSentence: "私はりんごを2つ持っています。"),
            SentenceResponse(englishSentence:"There is two apple.", japaneseSentence: "りんごが2つあります。"),
            SentenceResponse(englishSentence: "Why don't you delete apple.", japaneseSentence: "りんご削除はいかがですか。"),
            SentenceResponse(englishSentence: "I have three apple.", japaneseSentence: "私はりんごを3つ持っています。"),
            SentenceResponse(englishSentence:"There is three apple.", japaneseSentence: "りんごが3つあります。"),
            SentenceResponse(englishSentence: "Why don't you make apple.", japaneseSentence: "りんご作成はいかがですか。")
        ])
    static var previews: some View {
        @State var navigationPath: [NavigationPath] = []
        SelectSentenceView(navigationPath: $navigationPath, viewModel: SelectSentenceViewModel(newWordData: previewNewWordData))
    }
}
