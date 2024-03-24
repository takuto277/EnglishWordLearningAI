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
    case pathSelectSentence
}

struct ContentView: View {
    @State private var navigationPath: [NavigationPath] = []
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader { geometry in
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
            }
            .navigationDestination(for: NavigationPath.self) { value in
                switch value {
                case .pathWordList:
                    ContentView()
                case .pathInputWord:
                    InputWordView(navigationPath: $navigationPath)
                case .pathSelectSentence:
                 //TODO: 文章選択画面に遷移
                    InputWordView(navigationPath: $navigationPath)
                }
            }
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
