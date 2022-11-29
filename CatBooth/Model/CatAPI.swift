//
//  CatAPI.swift
//  CatBooth
//
//  Created by Ezekiel Abuhoff on 11/28/22.
//

import Foundation
import Combine

enum CatAPI {

    // MARK: - Endpoints
    static let baseURLString = "https://api.thecatapi.com/v1"

    static func listEndpoint(limit: Int = 10) -> String {
        "\(baseURLString)/images/search?limit=\(limit)"
    }

    // MARK: - Data Types
    struct Listing: Codable, Identifiable {
        let id: String
        let url: String
        let width: Int
        let height: Int
    }

    // MARK: - Error Handling
    enum CatError: Error {
        case invalidURL
        case invalidResponse
        case errorResponse(code: Int)
    }

    private static func checkStatusCode(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CatError.invalidResponse
        }
        guard httpResponse.statusCode >= 200,
              httpResponse.statusCode < 300 else {
            throw CatError.errorResponse(code: httpResponse.statusCode)
        }

        return data
    }

    // MARK: - Calls
    static func listCats(count: Int) -> AnyPublisher<[Listing], Error> {
        guard let url = URL(string: listEndpoint()) else { return Fail(error: CatError.invalidURL).eraseToAnyPublisher() }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap(checkStatusCode)
            .decode(type: [Listing].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
