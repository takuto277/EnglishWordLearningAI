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
    
    init(newImageData: NewImageData) {
        self.newImageData = newImageData
        
    }
    
    func setImageNumber(number: Int) {
        self.selectedImageNumber = number
    }
    
    func getSelectedImageNumber() -> Int? {
        return selectedImageNumber
    }
    //TODO: 保存処理(Realm)
}
