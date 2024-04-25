//
//  SelectSentenceViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation
import AVFoundation

final class SelectSentenceViewModel: ObservableObject {
    @Published var newWordData: NewWordData
    @Published var selectedSentenceNumber: Int?
    @Published var isButtonAvailable: Bool = false
    @Published private var speechSynthesizer: AVSpeechSynthesizer?
    
    init(newWordData: NewWordData) {
        self.newWordData = newWordData
        
        // 空文字を読んでおく
        speechSynthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "")
        utterance.volume = 0
        speechSynthesizer?.speak(utterance)
    }
    
    func setSentenceNumber(number: Int) {
        self.selectedSentenceNumber = number
        self.isButtonAvailable = true
    }
    
    func getSelectedSentenceNumber() -> Int? {
        return selectedSentenceNumber
    }
    
    func startSound(number: Int) {
        speechSynthesizer = AVSpeechSynthesizer()
        let text = AVSpeechUtterance(string: self.newWordData.response[number].englishSentence)
        let language = AVSpeechSynthesisVoice(language: "en-US")
        text.voice = language
        text.rate = 0.5
        speechSynthesizer?.speak(text)
    }
    
    func getNewImageData(completion: @escaping (NewImageData?) -> Void) {
        guard let selectedSentenceNumber = self.selectedSentenceNumber else {
            completion(nil)
            return
        }
        DispatchQueue.global().async {
            Task {
                do {
                    var responses: [String] = []
                    for _ in 0..<4 {
                        let urlString = try await AwsRepositoryImpl().getAIImage(inputText: self.newWordData.response[selectedSentenceNumber].englishSentence)
                        
                        
                        if let imageUrl = URL(string: urlString) {
                            let data = try await URLSession.shared.data(from: imageUrl)
                            let stringImage = data.0.base64EncodedString()
                            responses.append(stringImage)
                        }
                    }
                    
                    
                    
                    // 画像の取得処理が完了した後に指定の処理を実行する
                    let newImageData = NewImageData(englishWord: self.newWordData.englishWord,
                                                    japansesWord: self.newWordData.japansesWord,
                                                    englishSentence: self.newWordData.response[selectedSentenceNumber].englishSentence,
                                                    japaneseSentence: self.newWordData.response[selectedSentenceNumber].japaneseSentence,
                                                    imageResponse: responses )
                    DispatchQueue.main.async {
                        completion(newImageData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Error: \(error)")
                        completion(nil)
                    }
                }
            }
        }
    }
}
