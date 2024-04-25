//
//  AwsRepositoryImpl.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

class AwsRepositoryImpl: AwsRepository {
    var networkState = NetworkState()
    let api = APIProtocol()
    
    /// 生成AI画像を取得
    /// - parameter inputText: 入力テキスト
    /// - Returns: String
    func getAIImage(inputText: String) async throws -> String {
        let requestBody = CreateImageRequest(inputText: inputText)
        do {
            let result = try await api.getAIImage(parameter: requestBody)
            switch result {
            case .success(let data):
                return data.body.presignedURL
            case .failure(let error):
                throw error
            }
        } catch {
            throw APIError.unexpected
        }
    }
}
