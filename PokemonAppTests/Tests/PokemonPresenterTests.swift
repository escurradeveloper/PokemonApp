//
//  PokemonPresenterTests.swift
//  PokemonAppTests
//

import XCTest
@testable import PokemonApp

final class PokemonPresenterTests: XCTestCase {
    // MARK: - Properties
    private var sut: PokemonPresenter!
    private var spyInteractor: PokemonInteractorProtocolSpy!
    private var spyRouter: PokemonRouterProtocolSpy!
    private var loadPokemonCalled: [[PokemonModel]] = []
    private var listPokemon: [PokemonModel] = []
    private var searchEmptyPokemonViewCalled: [Bool] = []
    private var loadProgressViewCalled: [Bool] = []
    
    // MARK: Test lifecycle
    override  func setUp() {
        super.setUp()
        Task {
            await test_configure_pokemon_presenter()
        }
    }
    
    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    @MainActor
    func test_configure_pokemon_presenter() async {
        spyInteractor = PokemonInteractorProtocolSpy()
        spyRouter = PokemonRouterProtocolSpy()
        sut = PokemonPresenter(interactor: spyInteractor, router: spyRouter)
    }
    
    // MARK: - Tests
    @MainActor
    func test_get_list_pokemon() async {
        let pokemons = [PokemonMock.mew(),
                        PokemonMock.charmander()]
        XCTAssertNotEqual(loadProgressViewCalled, [true, false])
        XCTAssertNotEqual(loadPokemonCalled.first, pokemons)
    }
    
    @MainActor
    func test_search_pokemon_found_results() async {
        let pokemonName: String = "Mew"
        XCTAssertNotEqual(loadPokemonCalled.last?.count, 1)
        XCTAssertNotEqual(loadPokemonCalled.last?.first?.name, pokemonName)
        XCTAssertNotEqual(searchEmptyPokemonViewCalled.last, false)
    }
    
    @MainActor
    func test_search_pokemon_no_results() async {
        let pokemonName: String = .empty
        XCTAssertNil(loadPokemonCalled.last?.count)
        XCTAssertNil(loadPokemonCalled.last?.first?.name, pokemonName)
        XCTAssertNil(searchEmptyPokemonViewCalled.last)
    }
    
    @MainActor
    func test_go_to_pokemon() async {
        let pokemonModel: [PokemonModel] = [PokemonMock.mew()]
        XCTAssertNotEqual(listPokemon, pokemonModel)
    }
}
