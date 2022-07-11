//
//  TrimmingViewController.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/01.
//

import Foundation
import UIKit
import SwiftUI
import CropViewController


struct Trimming {
    @Binding var image: UIImage
    @Binding var display: Display
    @StateObject var viewModel: TrimmingViewModel
//    @Binding var isShowTorimmingView: Bool
}

extension Trimming: UIViewControllerRepresentable {
    typealias UIViewControllerType = CropViewController
    
    func makeUIViewController(context: Context) -> CropViewController {
        let cropViewController = CropViewController(croppingStyle: .default, image: image)
//        cropViewController.aspectRatioPickerButtonHidden = true
//        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
    
    func updateUIViewController(_ uiViewController: CropViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

final class Coordinator: NSObject, CropViewControllerDelegate {
    let parent: Trimming
    
    init(parent: Trimming) {
        self.parent = parent
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        parent.display = .photoLibrary
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int){
        parent.image = image
        parent.display = .setting
        print("とおってるよ")
    }
    
//    func cropViewController(_ cropViewController: CropViewController, didCropImageToRect cropRect: CGRect, angle: Int) {
//        parent.image = image
//        parent.display = .setting
//        print("とおってるよ")
//    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        parent.viewModel.trimmedImage = image
        parent.display = .setting
        print("とおってるよ")
    }
    
}

enum Display {
    case setting
    case photoLibrary
    case trimming
}
