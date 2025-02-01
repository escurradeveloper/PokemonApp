//
//  URLSessionExtensions.swift
//  PokemonApp
//

import Foundation

protocol URLSessionProtocol: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await self.data(from: url, delegate: nil)
    }
}
