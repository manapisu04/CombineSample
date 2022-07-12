//
//  FirstView.swift
//  CCCUltimate
//
//  Created by cmStudent on 2022/07/05.
//

import SwiftUI

struct FirstView: View {
    @StateObject var viewModel = TrimmingViewModel.trimmingViewModel
    var body: some View {
        VStack {
            if viewModel.isShowTrimming {
                
                if viewModel.image != nil {
                
                    TrimmingView(image: Binding($viewModel.image)!, viewModel: viewModel)
                    
                } else {
                    //TODO: なんの画面出そっかな〜
                }
                
            } else {
                if let image = viewModel.trimmedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Button {
                    viewModel.status = .photoLibrary
                } label: {
                    Text("新しくトリミングする！")
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
            ImagePicker(status: $viewModel.status, image: $viewModel.image, viewModel: viewModel)
        }
        .alert(viewModel.alertTitel, isPresented: $viewModel.isShowAlert) {
            
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
