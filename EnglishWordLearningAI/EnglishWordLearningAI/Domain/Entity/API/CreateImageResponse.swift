//
//  CreateImageResponse.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

struct CreateImageResponse: Codable {
    let statusCode: Int
    let body: Body
}

struct Body: Codable {
    let presignedURL: String

    enum CodingKeys: String, CodingKey {
        case presignedURL = "presigned_url"
    }
}
