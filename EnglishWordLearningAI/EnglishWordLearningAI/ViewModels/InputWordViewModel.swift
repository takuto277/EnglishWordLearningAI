//
//  InputWordViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation

final class InputWordViewModel: ObservableObject {
    // TODO: 入力値が日本語なら、英語翻訳/英語なら、日本語翻訳してそれぞれの値を返す処理
    //TODO: 文章生成APIRepository呼び出し処理(文章生成を実行予定)
    //TODO: 文章選択画面へ渡す値の詰め込み処理
    func getNewWordData() -> NewWordData {
        //TODO: 保持した値を詰め込んで返す
        return NewWordData(englishWord: "apple", japansesWord: "りんご", response: [SentenceResponse(englishSentence: "this is a apple.", japaneseSentence: "これはりんごです。")])
    }
}
