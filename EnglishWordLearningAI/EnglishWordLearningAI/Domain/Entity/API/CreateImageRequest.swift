//
//  CreateImageRequest.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

struct CreateImageRequest: Codable, Hashable {
    var inputText: String
    
    enum CodingKeys: String, CodingKey {
        case inputText = "input_text"
    }
}
