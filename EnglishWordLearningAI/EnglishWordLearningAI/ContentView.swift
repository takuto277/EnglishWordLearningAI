//
//  ContentView.swift
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
}

struct ContentView: View {
    @State private var navigationPath: [NavigationPath] = []
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                TopDesign(title: getTitle(for: navigationPath), height: 150, width: geometry.size.width)
                
                NavigationStack(path: $navigationPath) {
                    VStack {
                        List {
                            ForEach(items) { item in
                                NavigationLink {
                                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                } label: {
                                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                            ToolbarItem {
                                Button(action: addItem) {
                                    Label("Add Item", systemImage: "plus")
                                }
                            }
                        }
                        Spacer()
                        Button {
                            navigationPath.append(.pathInputWord)
                        } label: {
                            Text("英文作成画面へ")
                                .padding()
                            
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05, alignment: .center)
                        .background(Color.mint)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .navigationDestination(for: NavigationPath.self) { value in
                        switch value {
                        case .pathWordList:
                            ContentView()
                        case .pathInputWord:
                            InputWordView(navigationPath: $navigationPath,
                                          viewModel: InputWordViewModel())
                            .navigationBarBackButtonHidden(true)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
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
                        }
                    }
                }
                
                BottomDesign(height: 70, width: geometry.size.width)
            }
            .edgesIgnoringSafeArea(.all)
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
            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
