//
//  TrimmingViewModel.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/05.
//

import SwiftUI
import Combine

class TrimmingViewModel: ObservableObject {
    @Published var isShowPhotoLibrary = false
    @Published var isShowTrimming = false
    @Published var status: Display = .setting
    
    @Published var image: UIImage?
    @Published var trimmedImage: UIImage?
    
    var cancellables: [Cancellable] = []
    
    static var trimmingViewModel = TrimmingViewModel()
    
    private init() {
        
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
            guard let image = image else {
                print("かえれ〜！")
                return
            }
            
            // 保存する処理
            UIImageWriteToSavedPhotosAlbum(image,self,nil,nil)
        }
        
        cancellables.append(cancellable)
        cancellables.append(uiImageCancellable)
    }
    
    
}
