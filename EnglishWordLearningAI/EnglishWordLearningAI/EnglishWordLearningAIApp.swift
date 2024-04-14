//
//  EnglishWordLearningAIApp.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/02/09.
//

import SwiftUI
import SwiftData

@main
struct EnglishWordLearningAIApp: App {


    var body: some Scene {
        WindowGroup {
            WordListView(viewModel: WordListViewModel())
        }
    }
}
