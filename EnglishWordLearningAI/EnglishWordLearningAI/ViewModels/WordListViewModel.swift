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
    @Published var registerWordData: [RegisterWordData] = []
    private var repository: DatabaseRepositoryProtocol?
    
    init() {
        self.repository = DatabaseRepository()
        self.updateListData()
    }
    
    func deleteWord(index: Int) {
        guard let repository = repository else {
            return
        }
        if repository.deleteWord(registerWordData: registerWordData[index]) {
            self.updateListData()
        }
    }
    
    func updateListData() {
        // 初期化
        self.registerWordData = []
        // 更新処理
        self.repository?.fetchAllWords().forEach({ element in
            self.registerWordData.append(element)
        })
    }
}
