//
//  ContentView.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/28/22.
//

import SwiftUI

struct ContentView<CatList: CatListViewModel>: View {
    let viewModel: ContentViewModel<CatList>
    var body: some View {
        CatListView(viewModel: viewModel.catListViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(catListViewModel: TestCatListViewModel()))
    }
}
