//
//  CatImageView.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import SwiftUI
import Combine

// MARK: - Live UI
struct CatImageView<ViewModel: CatImageViewModel>: View {

    @ObservedObject var viewModel: ViewModel
    @State var image: UIImage?

    var defaultImage = UIImage(named: "cat_icon") ?? UIImage()

    var body: some View {
        Image(uiImage: (image ?? defaultImage))
            .onReceive(viewModel.$imageData) { newImageData in
                guard let newImageData = newImageData else { return }
                self.image = UIImage(data: newImageData)
            }
    }
}

// MARK: - Preview UI
struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        CatImageView(viewModel: CatImageViewModel.testMode())
    }
}
