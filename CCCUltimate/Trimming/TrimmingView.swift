//
//  TrimmingView.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/01.
//

import SwiftUI

struct TrimmingView: View {
    @Binding var image: UIImage
    @ObservedObject var viewModel:  TrimmingViewModel
    
    var body: some View {
        VStack {
            Trimming(image: $image, display: $viewModel.status, viewModel: viewModel)
        }
    }
}

