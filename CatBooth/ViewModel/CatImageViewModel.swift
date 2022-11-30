//
//  CatImageViewModel.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/29/22.
//

import Foundation
import Combine

class CatImageViewModel: ObservableObject {
    let dataPublisher: AnyPublisher<Data, Error>

    @Published var imageData: Data?
    @Published var error: Error?

    var sink: AnyCancellable?

    init(listing: CatAPI.Listing) {
        self.dataPublisher = CatAPI.getImageData(for: listing)

        sink = dataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case let .failure(error): self.error = error; print("ERROR: \(error)")
                }
            }, receiveValue: { data in
                self.imageData = data
            })
    }

    init(dataPublisher: AnyPublisher<Data, Error>) {
        self.dataPublisher = dataPublisher

        sink = dataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case let .failure(error): self.error = error; print("ERROR: \(error)")
                }
            }, receiveValue: { data in
                self.imageData = data
            })
    }
}

extension CatImageViewModel {
    static func testMode() -> CatImageViewModel {
        CatImageViewModel(dataPublisher: Fail(error: CatAPI.CatError.invalidURL).eraseToAnyPublisher())
    }
}
