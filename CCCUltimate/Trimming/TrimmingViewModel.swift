//
//  TrimmingViewModel.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/05.
//

import SwiftUI
import Combine

class TrimmingViewModel:NSObject, ObservableObject {
    @Published var isShowPhotoLibrary = false
    @Published var isShowTrimming = false
    @Published var status: Display = .setting
    
    @Published var image: UIImage?
    @Published var trimmedImage: UIImage?
    
    var cancellables: [Cancellable] = []
    
    static var trimmingViewModel = TrimmingViewModel()
    
    var alertTitel: String = ""
    @Published var isShowAlert = false
    
    private override init() {
        super.init()
        // statusが変化したら、画面遷移
        let cancellable = $status.sink { [weak self] display in
            guard let self = self else {
                return
            }
            switch display {
            case .setting:
                self.isShowPhotoLibrary = false
                self.isShowTrimming = false
                
            case .photoLibrary:
                self.isShowPhotoLibrary = true
                self.isShowTrimming = false
            case .trimming:
                self.isShowPhotoLibrary = false
                self.isShowTrimming = true
            }
        }
        
        // トリミングが終わったら、保存する
        let uiImageCancellable = $trimmedImage.sink { [weak self] image in
            guard let image = image, let self = self else {
                print("かえれ〜！")
                return
            }
            
            // 保存する処理
            //MARK: Modelじゃなくてもいいかなと思いました
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imageSaveCompletion(_:didFinishSavingWithError:context:)), nil)
        }
        
        cancellables.append(cancellable)
        cancellables.append(uiImageCancellable)
    }
    
    @objc func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, context: UnsafeRawPointer) {
        alertTitel = error == nil ? "保存できたよ" : error?.localizedDescription ?? "ごめんね"
        isShowAlert = true
    }
    
}
