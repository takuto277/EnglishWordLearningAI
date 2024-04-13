//
//  WordListView.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/02/09.
//

import SwiftUI
import SwiftData

enum NavigationPath: Hashable {
    case pathWordList
    case pathInputWord
    case pathSelectSentence(NewWordData)
    case pathSelectImage(NewImageData)
    case pathRegisterComplete(RegisterWordData)
    case pathWordDetail(RegisterWordData)
}

struct WordListView<ViewModel: WordListViewModel>: View {
    @State private var navigationPath: [NavigationPath] = []
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: ViewModel
    @State private var isplusButtonVisible = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center) {
                    TopDesign(title: getTitle(for: navigationPath), height: 150, width: geometry.size.width)
                    
                    NavigationStack(path: $navigationPath) {
                        VStack {
                            List {
                                ForEach(Array(viewModel.registerWordData?.enumerated() ?? [].enumerated()), id: \.0) { index, element in
                                    Button(action: {
                                        navigationPath.append(.pathWordDetail(element))
                                    }) {
                                        WordListCell(registerWordData: element)
                                    }
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        viewModel.deleteWord(index: index)
                                    }
                                }
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                            }
                        }
                        .navigationDestination(for: NavigationPath.self) { value in
                            switch value {
                            case .pathWordList:
                                WordListView(viewModel: WordListViewModel() as! ViewModel)
                            case .pathInputWord:
                                InputWordView(navigationPath: $navigationPath,
                                              viewModel: InputWordViewModel())
                                .navigationBarBackButtonHidden(true)
                            case .pathSelectSentence(let newWordData):
                                SelectSentenceView(navigationPath: $navigationPath,
                                                   viewModel: SelectSentenceViewModel(newWordData: newWordData))
                                .navigationBarBackButtonHidden(true)
                            case .pathSelectImage(let newImageData):
                                SelectImageView(navigationPath: $navigationPath,
                                                viewModel: SelectImageViewModel(newImageData: newImageData))
                                .navigationBarBackButtonHidden(true)
                            case .pathRegisterComplete(let registerWordData):
                                RegisterCompleteView(navigationPath: $navigationPath,
                                                     viewModel: RegisterCompleteViewModel(registerWordData: registerWordData))
                                .navigationBarBackButtonHidden(true)
                            case .pathWordDetail(let registerWordData):
                                WordDetailView(navigationPath: $navigationPath,
                                                     viewModel: WordDetailViewModel(registerWordData: registerWordData))
                                .navigationBarBackButtonHidden(true)
                            }
                        }
                        .onAppear {
                            self.isplusButtonVisible = true
                        }
                        .onDisappear {
                            self.isplusButtonVisible = false
                        }
                    }
                    
                    BottomDesign(height: 70, width: geometry.size.width)
                }
                .edgesIgnoringSafeArea(.all)
                
                if self.isplusButtonVisible {
                    HStack {
                        Spacer()
                        Button(action: {
                            navigationPath.append(.pathInputWord)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.positive)
                        }
                        .offset(x: -5, y: 0)
                    }
                }
            }
        }
    }
    
    func getTitle(for navigationPath: [NavigationPath]) -> String {
        guard let lastPath = navigationPath.last else {
            return "単語一覧"
        }
        
        switch lastPath {
        case .pathWordList:
            return "単語一覧"
        case .pathInputWord:
            return "英文作成"
        case .pathSelectSentence:
            return "文章選択"
        case .pathSelectImage:
            return "イメージ画像選択"
        case .pathRegisterComplete:
            return "登録完了"
        case .pathWordDetail:
            return "単語詳細"
        }
    }
    
}

struct WordListCell: View {
    var registerWordData: RegisterWordData
    
    var body: some View {
        HStack {
            let data = Data(base64Encoded: registerWordData.imageString)
            Image(uiImage: (UIImage(data: data ?? Data()) ?? UIImage(named: "NoImage")) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(registerWordData.englishWord)
                    .font(.custom("STBaoliTC-Regular", size: 20))
                    .foregroundColor(.black)
                Text(registerWordData.japansesWord)
                    .font(.custom("STBaoliTC-Regular", size: 15))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
        }
        .padding(8)
    }
}

