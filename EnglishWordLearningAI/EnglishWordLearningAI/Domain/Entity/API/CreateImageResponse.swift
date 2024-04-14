//
//  CreateImageResponse.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

struct CreateImageResponse: Codable, Hashable {
    var presignedUrl: String
    
    enum CodingKeys: String, CodingKey {
        case presignedUrl = "presigned_url"
    }
}
