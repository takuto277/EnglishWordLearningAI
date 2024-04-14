//
//  SelectSentenceViewModel.swift
//  EnglishWordLearningAI
//
//  Created by 小野拓人 on 2024/03/22.
//

import Foundation

final class SelectSentenceViewModel: ObservableObject {
    @Published var newWordData: NewWordData
    @Published var selectedSentenceNumber: Int?
    @Published var isButtonAvailable: Bool = false
    
    init(newWordData: NewWordData) {
        self.newWordData = newWordData
    }
    
    func setSentenceNumber(number: Int) {
        self.selectedSentenceNumber = number
        self.isButtonAvailable = true
    }
    
    func getSelectedSentenceNumber() -> Int? {
        return selectedSentenceNumber
    }
    
    func getNewImageData(completion: @escaping (NewImageData?) -> Void) {
        // TODO: ここのテスト用画像は一定時間でアクセス権限無くなるので注意(画像を読み込みたいなら再度作成して)
        let urlString = "https://english-create-image.s3.amazonaws.com/0c15ccb2a8094b8cbe0cb0b31ddc7168.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAZXTPXWMH2I5WMVIT%2F20240406%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240406T105039Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDGwijEi7OMtgqAqL%2BCF1sX3DMabUWYdVBcFvzP5cmnXAIgYtGYVr7jBGkahpuFcYCvxz3Dpccz9Djw5QiLtvTDJXsqhwMIvP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw2NjkxNzU0OTMzOTEiDAl631eAicWMq3HSqCrbAp%2Bkx7ZSp0dC0RmQHQ0TDYePiU5WVIhDDVyAD%2FSZZfT6guDVM4XLCFK5KworRz6ySPPzv2CG7DfLunL2Oph1gCIEYeQXiPb61cJxHTG6J1Wv0wzpFjy1Sv9lgisz%2FcJNF5bGR%2FS7w%2BHzVrKVr3L1BA0w8k39x2%2Bzw7Q%2BlhUOe13Yf6asWNhY2mpkQxCK380%2BQr0CaYY7blccMlMhxG6Z9wjrD9N8dkgHEV%2FCEmcaz0Zo9VxF0rKBx1DiipqJHS7jRub2sGcahoICs2yo8VZdlCEwLNWIH0QQZkT604KkML7mJBOTA3ddP2S08PCrYT1MBui1saZlGbDLbupLUfJ5nL%2B4FrQl7rDV5NTb1ROmG17chaHxbbUb%2BuSmAOe6d1BNicWyi6FxWRzcvRtei7ebSiaI%2FZNuoESNKyYxdx7krbTVulVC3W8Ji9%2BuP9qHmvCkwGsxQSn2BT9zlhRDMPfRxLAGOp4BkvQhxBD7qvO%2FCoJNnOYSJK4LUq8Cszv1s64W3HWvO%2Fp8H7kzTYjAq9KB4wfwFxZlNtm9SdMZCTuTBJ%2Ferc1wPfeAf5Flfbtyp4%2BlHn1iA9i6QBrH%2FTuv%2FGymqAVIfVCKSyYEfH%2BPWBzqmL%2BGM9UHg7yzJgrPJ7XA0Wtz7JsPDiyayC2cyDoN9HfeCbyjySSGoV3dcZ8tS3eRHn07gNs%3D&X-Amz-Signature=c3850b20ca6e411f0befe261a149f0d6b1e913a20be8e787c8f53c105ce4704d"
        var response: [String] = []
        
        if let imageUrl = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                
                let stringImage = data.base64EncodedString()
                response.append(stringImage)
                response.append(stringImage)
                response.append(stringImage)
                response.append(stringImage)
                
                guard let selectedSentenceNumber = self.selectedSentenceNumber else {
                    completion(nil)
                    return
                }
                
                // 画像の取得処理が完了した後に指定の処理を実行する
                let newImageData = NewImageData(englishWord: self.newWordData.englishWord,
                                                japansesWord: self.newWordData.japansesWord,
                                                englishSentence: self.newWordData.response[selectedSentenceNumber].englishSentence,
                                                japaneseSentence: self.newWordData.response[selectedSentenceNumber].japaneseSentence,
                                                imageResponse: response )
                completion(newImageData)
                
            }
            task.resume()
        }
    }
    //TODO: 画像生成APIRepository呼び出し処理(画像生成を実行予定)
}
