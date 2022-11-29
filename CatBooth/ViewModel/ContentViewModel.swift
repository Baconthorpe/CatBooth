//
//  ContentViewModel.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import Foundation
import Combine

struct ContentViewModel<CatList: CatListViewModel> {
    let catListViewModel: CatList
}
