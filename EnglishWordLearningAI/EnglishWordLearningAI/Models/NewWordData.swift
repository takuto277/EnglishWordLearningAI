//
//  NewWordData.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation

// 文章選択画面で使用する構造体
struct NewWordData: Decodable, Hashable {
    let englishWord: String
    let japansesWord: String
    let response: [SentenceResponse]
}

// 文章生成のレスポンス
struct SentenceResponse: Decodable, Hashable {
    let englishSentence: String
    let japaneseSentence: String
}
