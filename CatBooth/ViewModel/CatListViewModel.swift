//
//  CatListViewModel.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import Foundation
import Combine

protocol CatListViewModel: ObservableObject {
    var listings: [CatAPI.Listing] { get }
    var error: Error? { get }

    func refresh()
}

class LiveCatListViewModel: CatListViewModel {
    @Published var listings: [CatAPI.Listing] = []
    @Published var error: Error?

    var sink: AnyCancellable?

    // MARK: - Receiving Values
    func receive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case let .failure(error): self.error = error; print("ERROR: \(error)")
        }
    }

    func receive(value: [CatAPI.Listing]) {
        self.listings = value
    }

    // MARK: - Public Functions
    func refresh() {
        sink = CatAPI.listCats(count: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: receive, receiveValue: receive)
    }
}

class TestCatListViewModel: CatListViewModel {
    @Published var listings: [CatAPI.Listing] = []
    @Published var error: Error?

    func refresh() {
        listings = [
            CatAPI.Listing(id: "burp", url: "zurp", width: 1, height: 1),
            CatAPI.Listing(id: "durp", url: "wurp", width: 1, height: 1)
        ]
    }
}
