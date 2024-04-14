//
//  APIProtocol.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

class APIProtocol {
    
    
    /// 生成AI画像を取得
    /// - Parameter parameter: CreateImageRequest
    /// - Returns: Result<CreateImageResponse, Error>
    func getAIImage(parameter: CreateImageRequest) async throws -> Result<CreateImageResponse, Error> {
        guard let url = URL(string: Const.API_BASE_URL) else { throw APIError.unexpected }
        guard let data = try? JSONEncoder().encode(parameter) else { throw APIError.failedEncode }
        
        var request = URLRequest(url: url)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unexpected
            }
            if !(200...299).contains(httpResponse.statusCode) {
                throw APIError.unexpected
            }
            guard let result = try? JSONDecoder().decode(CreateImageResponse.self, from: data) else { throw APIError.failedDecode }
            return .success(result)
        } catch {
            throw APIError.unexpected
        }
    }
}
