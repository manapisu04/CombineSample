//
//  ImagePicker.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/06.
//

import SwiftUI

struct ImagePicker {
    // Viewとして使うんだよね
    @Binding var status: Display
    @Binding var image: UIImage?
    //FIXME: え〜これいるか？
    @StateObject var viewModel: TrimmingViewModel
}

extension ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    // 初めて描画するときの処理
    // TODO: Selfじゃだめ？
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        // 参照型のclass
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    // 更新した時の処理
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // なし！
    }
    
    // 勝手に作られる
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }
}

// ハッピ~セ~ット
final class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    // 写真を選んだときの処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[.originalImage] as? UIImage else {
            return
        }
        
        self.parent.image = originalImage
        self.parent.status = .trimming
    }
    
    // キャンセルボタンを押した処理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.parent.status = .setting
    }
}


