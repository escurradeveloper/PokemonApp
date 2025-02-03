//
//  PokemonAPITests.swift
//  PokemonAppTests
//

import XCTest
@testable import PokemonApp

class PokemonAPITests: XCTestCase {
    // MARK: - Properties
    var sut: PokemonAPI!
    var urlSession: URLSessionSpy!
    
    // MARK: - Test setup
    func test_get_pokemon_success() async {
        givenSut()
        let expectedURL = URL(string: Constants.Urls.baseUrl + Constants.ApiVersion.version + "/pokemon?limit=151")!
        let pokemonName: String = "bulbasaur"
        let data = mockPokemonData()
        givenUrlSessionSuccess(url: expectedURL, data: data, statusCode: 200)
        let result = await sut.getListPokemon()
        switch result {
        case .success(let pokemons):
            XCTAssertEqual(pokemons.count, 1)
            XCTAssertEqual(pokemons.first?.name, pokemonName)
            XCTAssertEqual(urlSession.didDataParameters?.url, expectedURL)
        case .failure(let error):
            XCTFail("Error failed: \(error)")
        }
    }
    
    func test_get_pokemon_failure() async {
        givenSut()
        givenUrlSessionWithError()
        let result = await sut.getListPokemon()
        switch result {
        case .success:
            XCTFail("Success")
        case .failure:
            XCTAssertTrue(urlSession.didData)
            XCTAssertTrue(true)
        }
    }
    
    func test_get_pokemon_detail_success() async {
        givenSut()
        let expectedURL = URL(string: Constants.Urls.baseUrl + Constants.ApiVersion.version + "/pokemon/1")!
        let data = mockPokemonDetailData()
        givenUrlSessionSuccess(url: expectedURL, data: data, statusCode: 200)
        let result =  await sut.getPokemonDetail(pokemonId: 1)
        switch result {
        case .success(let pokemonDetail):
            XCTAssertEqual(pokemonDetail.height, 7)
            XCTAssertEqual(pokemonDetail.weight, 69)
            XCTAssertEqual(pokemonDetail.types, ["grass", "poison"])
            XCTAssertEqual(urlSession.didDataParameters?.url, expectedURL)
        case .failure(let error):
            XCTFail("Error failed: \(error)")
        }
    }
    
    private func givenSut() {
        urlSession = URLSessionSpy()
        sut = PokemonAPI(session: urlSession)
    }
    
    private func givenUrlSessionSuccess(url: URL, data: Data, statusCode: Int) {
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        urlSession.dataResult = (data, response)
    }
    
    private func givenUrlSessionWithError() {
        urlSession.dataError = URLError(.notConnectedToInternet)
    }
    
    private func mockPokemonData() -> Data {
        return PokemonMock.mockPokemonData.data(using: .utf8) ?? Data()
    }
    
    private func mockPokemonDetailData() -> Data {
        return PokemonMock.mockPokemonDetailData.data(using: .utf8) ?? Data()
    }
}
