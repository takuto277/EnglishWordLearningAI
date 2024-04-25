//
//  InputWordViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation
import MLKitTranslate

final class InputWordViewModel: ObservableObject {
    //TODO: 文章生成APIRepository呼び出し処理(文章生成を実行予定)
    //TODO: 文章選択画面へ渡す値の詰め込み処理
    func getNewWordData(text: String, completion: @escaping (NewWordData?) -> Void) {
        let options = TranslatorOptions(sourceLanguage: .japanese, targetLanguage: .english)
            let japaneseEnglishTranslator = Translator.translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        japaneseEnglishTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            japaneseEnglishTranslator.translate(text) { translatedText, error in
                      guard error == nil, let translatedText = translatedText else { return }
                
                completion(NewWordData(englishWord: translatedText, japansesWord: text, response: [SentenceResponse(englishSentence: translatedText, japaneseSentence: text)]))
                      // Translation succeeded.
                  }
            // Model downloaded successfully. Okay to start translating.
        }
//        let options = TranslatorOptions(sourceLanguage: .en, targetLanguage: .de)
//        let englishGermanTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
       
    }
}
