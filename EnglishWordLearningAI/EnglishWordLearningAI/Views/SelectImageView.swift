//
//  SelectImageView.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/06.
//

import SwiftUI
import SVProgressHUD

struct SelectImageView<ViewModel: SelectImageViewModel>: View {
    @Binding var navigationPath: [NavigationPath]
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text(viewModel.newImageData.englishSentence)
                    .font(.custom("STBaoliTC-Regular", size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.newImageData.japaneseSentence)
                    .font(.custom("STBaoliTC-Regular", size: 15))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                    let response = viewModel.newImageData.imageResponse
                    ForEach(0..<response.count, id: \.self) { index in
                        let data = Data(base64Encoded: response[index])
                        // 画像を表示し、タップされたら selectedImageIndex を更新する
                        Image(uiImage: (UIImage(data: data ?? Data()) ?? UIImage(named: "NoImage")) ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                viewModel.setImageNumber(number: index)
                            }
                        // 選択された画像には枠線を追加する
                            .border(viewModel.selectedImageNumber == index ? Color.positivePush : Color.clear, width: 3)
                    }
                }
                .padding()
                
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
                        // TODO: 選択した画像を用いて保存処理
                        // TODO: その後に遷移: 
                        SVProgressHUD.show()
                        viewModel.register { registerWordData  in
                            SVProgressHUD.dismiss()
                            navigationPath.append(.pathRegisterComplete(registerWordData))
                        }
                    } label: {
                        Text("決定")
                            .font(.custom("STBaoliTC-Regular", size: 15))
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.02)
                    }
                    .padding()
                    .buttonStyle(PositiveButton())
                }
            }
            .padding()
            .frame(width: geometry.size.width)
        }
    }
}

struct SelectImageView_Previews: PreviewProvider {
    @Environment(\.dismiss) var dismiss
    static let previewNewImageData: NewImageData = NewImageData(englishWord: "cat",
                                                                japansesWord: "猫",
                                                                englishSentence: "this is a cat.",
                                                                japaneseSentence: "これは猫です。",
                                                                imageResponse: [])
    static var previews: some View {
        @State var navigationPath: [NavigationPath] = []
        SelectImageView(navigationPath: $navigationPath, viewModel: SelectImageViewModel(newImageData: previewNewImageData))
    }
}
