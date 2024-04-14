//
//  AwsRepository.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

protocol AwsRepository {
    func getAIImage(inputText: String) async throws -> String
}
