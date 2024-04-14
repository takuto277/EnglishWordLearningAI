//
//  LogUtil.swift
//  EnglishWordLearningAI
//
//  Created by 中川晋太朗 on 2024/04/13.
//

import Foundation

class LogUtil {

    /// 日付の出力フォーマット
    private static let dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"

    /// ログ出力
    class func log(_ message: String = "", file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = createLogMessage(message, file: file, function: function, line: line)
        print(logMessage)
    }

    /// ログ＋エラー出力
    class func errorLog(_ message: String = "", error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        let logMessage = createLogMessage(message, error: error, file: file, function: function, line: line)
        print(logMessage)
    }

    /// 現在時刻の取得
    private class func nowDateTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        return formatter.string(from: Date())
    }

    /// ログに表示する文字列を生成
    private class func createLogMessage(_ message: String, error: Error? = nil, file: String, function: String, line: Int) -> String {
        var logMessage = nowDateTime()

        if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            logMessage += " [\(bundleName)]"
        }

        if let swiftFile = file.split(separator: "/").last?.split(separator: ".").first {
            logMessage += " [\(String(swiftFile))]"
        }

        logMessage += " <\(function)>"
        logMessage += " [l: \(line)] "
        logMessage += message

        if let error = error {
            logMessage += "\n\(error)"
        }

        return logMessage
    }
}

