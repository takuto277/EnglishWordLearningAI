//
//  SelectSentenceViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation

final class SelectSentenceViewModel: ObservableObject {
    @Published var newWordData: NewWordData
    private var selectedSentenceNumber: Int?
    
    init(newWordData: NewWordData) {
        self.newWordData = newWordData
    }
    
    func setSentenceNumber(number: Int) {
        self.selectedSentenceNumber = number
    }
    
    func getSelectedSentenceNumber() -> Int? {
        return selectedSentenceNumber
    }
    //TODO: 画像生成APIRepository呼び出し処理(画像生成を実行予定)
    //TODO: イメージ画像選択画面へ渡す値の詰め込み処理
}