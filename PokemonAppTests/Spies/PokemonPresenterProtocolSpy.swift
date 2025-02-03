//
//  PokemonPresenterProtocolSpy.swift
//  PokemonApp
//

@testable import PokemonApp

@MainActor
class PokemonPresenterProtocolSpy: PokemonPresenterProtocol, PokemonPresenterVariablesProtocol {
    // MARK: - Properties
    var didGetListPokemon = false
    var didSearchPokemon = false
    var didGoToPokemon = false
    var loadPokemon: (([PokemonModel]) -> Void)? = nil
    var searchEmptyPokemon: ((Bool) -> Void)? = nil
    var loadProgress: ((Bool) -> Void)? = nil
    var dataEmpty: (() -> Void)? = nil
    var pokemonName: String = .empty
    var pokemonIndex: Int = 0
    
    // MARK: - Functions
    func getListPokemon() async {
        self.didGetListPokemon = true
    }
    
    func searchPokemon(pokemonName: String) {
        self.didSearchPokemon = true
        self.pokemonName = pokemonName
    }
    
    func goToPokemon(pokemonIndex: Int) {
        self.didGoToPokemon = true
        self.pokemonIndex = pokemonIndex
    }
}
