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

// 画像選択画面で使用する構造体(画像生成のレスポンス込み)
struct NewImageData: Decodable, Hashable {
    let englishWord: String
    let japansesWord: String
    let englishSentence: String
    let japaneseSentence: String
    let imageResponse: [String]
}

// 登録完了画面で使用する構造体
struct RegisterWordData: Decodable, Hashable {
    let englishWord: String
    let japansesWord: String
    let englishSentence: String
    let japaneseSentence: String
    let imageString: String
    var wordNumber: Int = 0
}

extension RegisterWordData {
    func toRealmObject() -> RegisterWordDataObject {
        let realmObject = RegisterWordDataObject()
        realmObject.englishWord = self.englishWord
        realmObject.japansesWord = self.japansesWord
        realmObject.englishSentence = self.englishSentence
        realmObject.japaneseSentence = self.japaneseSentence
        realmObject.imageString = self.imageString
        realmObject.wordNumber = self.wordNumber
        return realmObject
    }
}
