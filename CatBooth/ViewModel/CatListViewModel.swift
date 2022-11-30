//
//  CatListViewModel.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import Foundation
import Combine

// MARK: - Protocol
protocol CatListViewModel: ObservableObject {
    var listings: [CatAPI.Listing] { get }
    var error: Error? { get }

    func refresh()
}

// MARK: - Live Implementation
class LiveCatListViewModel: CatListViewModel {
    @Published var listings: [CatAPI.Listing] = []
    @Published var error: Error?

    var listingSink: AnyCancellable?
    var imageDataSink: AnyCancellable?

    // MARK: - Receiving Values
    private func receive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case let .failure(error): self.error = error; print("ERROR: \(error)")
        }
    }

    private func receive(value: [CatAPI.Listing]) {
        self.listings = value
    }

    // MARK: - Public Functions
    public func refresh() {
        listingSink = CatAPI.listCats(count: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: receive, receiveValue: receive)
    }
}

// MARK: - Test Implementation
class PreviewCatListViewModel: CatListViewModel {
    @Published var listings: [CatAPI.Listing] = []
    @Published var error: Error?

    public func refresh() {
        listings = [
            CatAPI.Listing(id: "burp", url: "zurp", width: 1, height: 1),
            CatAPI.Listing(id: "durp", url: "wurp", width: 1, height: 1)
        ]
    }
}
