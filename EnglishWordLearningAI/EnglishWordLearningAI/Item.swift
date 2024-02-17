//
//  Item.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/02/09.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
