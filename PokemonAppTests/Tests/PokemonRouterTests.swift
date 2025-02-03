//
//  PokemonRouterTests.swift
//  PokemonAppTests
//

import XCTest
@testable import PokemonApp

final class PokemonRouterTests: XCTestCase {
    // MARK: - Properties
    private var sut: PokemonRouter!
    private var window: UIWindow? = UIWindow()
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        Task {
            await test_configure_pokemon_router()
        }
    }
    
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    @MainActor
    func test_configure_pokemon_router() {
        guard let windowRouter = window else {
            return
        }
        sut = PokemonRouter(window: windowRouter)
    }

    @MainActor
    func test_configure_list_pokemon() async {
        sut.configureListPokemon()
        XCTAssertNoThrow(sut.configureListPokemon())
    }
    
    @MainActor
    func test_pokemon_model() {
        let pokemonModel: PokemonModel = PokemonMock.charmander()
        XCTAssertNoThrow(pokemonModel)
    }
}
