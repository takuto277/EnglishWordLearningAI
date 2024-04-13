//
//  WordListViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import Foundation

// TODO: 削除予定
import SwiftUI

final class WordListViewModel: ObservableObject {
    @Published var registerWordData: [RegisterWordData]?
    
    init() {
        self.registerWordData = []
        for _ in 0..<20 {
            let test = RegisterWordData(englishWord: "apple",
                                                     japansesWord: "りんご",
                                                     englishSentence: "apple pen",
                                                     japaneseSentence: "りんごペン",
                                                     imageString: "hoge")
            registerWordData?.append(test)
        }
    }
    
    func deleteWord(index: Int) {
        
    }
}
