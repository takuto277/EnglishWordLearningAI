//
//  WordDetailViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import Foundation
import AVFoundation

final class WordDetailViewModel: ObservableObject {
    @Published var registerWordData: RegisterWordData
    @Published private var speechSynthesizer: AVSpeechSynthesizer?
    
    init(registerWordData: RegisterWordData) {
        self.registerWordData = registerWordData
        
        // 空文字を読んでおく
        speechSynthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "")
        utterance.volume = 0
        speechSynthesizer?.speak(utterance)
    }
    
    func startSound() {
        speechSynthesizer = AVSpeechSynthesizer()
        let text = AVSpeechUtterance(string: self.registerWordData.englishSentence)
        let language = AVSpeechSynthesisVoice(language: "en-US")
        text.voice = language
        text.rate = 0.5
        speechSynthesizer?.speak(text)
    }
}
