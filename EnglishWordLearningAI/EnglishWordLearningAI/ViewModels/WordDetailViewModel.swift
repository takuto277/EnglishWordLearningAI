//
//  WordDetailViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import Foundation

final class WordDetailViewModel: ObservableObject {
    @Published var registerWordData: RegisterWordData
    
    init(registerWordData: RegisterWordData) {
        self.registerWordData = registerWordData
        
    }
}
