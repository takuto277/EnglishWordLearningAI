//
//  SelectImageViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/06.
//

import Foundation

final class SelectImageViewModel: ObservableObject {
    @Published var newImageData: NewImageData
    @Published var selectedImageNumber: Int?
    @Published var isButtonAvailable: Bool = false
    private var repository: DatabaseRepositoryProtocol?
    
    init(newImageData: NewImageData) {
        self.newImageData = newImageData
        self.repository = DatabaseRepository()
    }
    
    init(newImageData: NewImageData, repository: DatabaseRepositoryProtocol) {
        self.newImageData = newImageData
        self.repository = repository
    }
    
    func setImageNumber(number: Int) {
        self.selectedImageNumber = number
        self.isButtonAvailable = true
    }
    
    func getSelectedImageNumber() -> Int? {
        return selectedImageNumber
    }
    
    func register(completion: @escaping (RegisterWordData?) -> Void) {
        guard let selectedImageNumber = selectedImageNumber,
              let repository = repository else {
            completion(nil)
            return
        }
        
        let registerWordData = RegisterWordData(englishWord: newImageData.englishWord,
                                                japansesWord: newImageData.japansesWord,
                                                englishSentence: newImageData.englishSentence,
                                                japaneseSentence: newImageData.japaneseSentence,
                                                imageString: newImageData.imageResponse[selectedImageNumber])
        if repository.addWord(registerWordData: registerWordData) {
            completion(registerWordData)
        } else {
            completion(nil)
        }
    }
}
