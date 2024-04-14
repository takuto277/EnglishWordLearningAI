//
//  APIError.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

enum APIError: Error {
    case noError
    case network
    case parameter
    case failedEncode
    case failedDecode
    case unexpected
    
    var errorMessage: String {
        switch self {
        case .noError: return "成功"
        case .network: return "ネットワーク未接続"
        case .parameter: return "パラメータが不正"
        case .failedEncode: return "エンコードエラー"
        case .failedDecode: return "デコードエラー"
        case .unexpected: return "想定外のエラー"
        }
    }
}
