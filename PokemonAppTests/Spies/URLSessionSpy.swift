//
//  URLSessionSpy.swift
//  PokemonApp
//

import Foundation
@testable import PokemonApp

class URLSessionSpy: URLSessionProtocol, @unchecked Sendable {
    var didData = false
    var didDataParameters: (url: URL, Void)?
    var didDataParametersList = [(url: URL, Void)]()
    var dataError: Error?
    var dataResult: (Data, URLResponse)!

    func data(from url: URL) async throws -> (Data, URLResponse) {
        didData = true
        didDataParameters = (url, ())
        didDataParametersList.append((url, ()))
        if let error = dataError {
            throw error
        }
        return dataResult
    }
}
