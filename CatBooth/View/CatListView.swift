//
//  CatListView.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import SwiftUI

struct CatListView<ViewModel: CatListViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Text("GOOP")
        List(viewModel.listings) { listing in
            Text("URL:")
            Text(listing.url)
        }.onAppear {
            viewModel.refresh()
        }

//        Grid {
//            Image(uiImage: <#T##UIImage#>)
//        }
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(viewModel: TestCatListViewModel())
    }
}
