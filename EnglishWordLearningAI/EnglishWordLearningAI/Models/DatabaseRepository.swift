//
//  DatabaseRepository.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import Foundation

protocol DatabaseRepositoryProtocol: AnyObject {
    func addWord(registerWordData: RegisterWordData) -> Bool
    func deleteWord(registerWordData: RegisterWordData) -> Bool
    func fetchAllWords() -> [RegisterWordData]
}

class DatabaseRepository: DatabaseRepositoryProtocol {
    let service = DatabaseService()
    
    func addWord(registerWordData: RegisterWordData) -> Bool {
        return service.addNewWord(registerWordData: registerWordData)
    }
    
    func deleteWord(registerWordData: RegisterWordData) -> Bool {
        return service.deleteWord(registerWordData: registerWordData)
    }
    
    func fetchAllWords() -> [RegisterWordData] {
        return service.fetchAllWords()
    }
}
