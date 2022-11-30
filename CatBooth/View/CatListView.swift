//
//  CatListView.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import SwiftUI

// MARK: - Live UI
struct CatListView<ViewModel: CatListViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Text("CATS!")
            .fontWeight(.heavy)
            .dynamicTypeSize(.large)
        List(viewModel.listings) { listing in
            CatImageView(viewModel: CatImageViewModel(listing: listing))
            Text("URL: \(listing.url)")
        }.onAppear {
            viewModel.refresh()
        }
    }
}

// MARK: - Preview UI
struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(viewModel: PreviewCatListViewModel())
    }
}
