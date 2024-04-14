//
//  DatabaseService.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/04/13.
//

import Foundation
import RealmSwift

class RegisterWordDataObject: Object {
    @Persisted var englishWord: String = ""
    @Persisted var japansesWord: String = ""
    @Persisted var englishSentence: String = ""
    @Persisted var japaneseSentence: String = ""
    @Persisted var imageString: String = ""
    @Persisted var wordNumber: Int = 0
    
    func toRegisterWordData() -> RegisterWordData {
        return RegisterWordData(englishWord: self.englishWord,
                                japansesWord: self.japansesWord,
                                englishSentence: self.englishSentence,
                                japaneseSentence: self.japaneseSentence,
                                imageString: self.imageString,
                                wordNumber: self.wordNumber)
    }
}

@objcMembers class DatabaseService {
    
    var realmObject = try? Realm()
    
    // 直近のデータの番号を取得する
    func getLastWordNumber() -> Int {
        guard let lastWord = realmObject?.objects(RegisterWordDataObject.self).last else {
            return 0 // データがない場合は0を返す
        }
        return lastWord.wordNumber
    }
    
    // データの登録
    func addNewWord(registerWordData: RegisterWordData) -> Bool {
        let registerWordDataObject = registerWordData.toRealmObject()
        let wordNumber = getLastWordNumber() + 1
        registerWordDataObject.wordNumber = wordNumber
        do {
            try realmObject?.write {
                realmObject?.add(registerWordDataObject)
            }
            return true
        } catch {
            print("Error adding word to Realm: \(error.localizedDescription)")
            return false
        }
    }
    
    // データの削除
    func deleteWord(registerWordData: RegisterWordData) -> Bool {
        if let registerWordDataObjects = realmObject?.objects(RegisterWordDataObject.self),
           let registerWordDataObject = registerWordDataObjects.first(where: { $0.wordNumber == registerWordData.wordNumber }) {
            do {
                try realmObject?.write {
                    realmObject?.delete(registerWordDataObject)
                }
                return true
            } catch {
                print("Error deleting word to Realm: \(error.localizedDescription)")
                return false
            }
        }
        return false
    }
    
    // データの取得
    func fetchAllWords() -> [RegisterWordData] {
        guard let objects = realmObject?.objects(RegisterWordDataObject.self) else {
            return []
        }
        return objects.map { $0.toRegisterWordData() }
    }
}
