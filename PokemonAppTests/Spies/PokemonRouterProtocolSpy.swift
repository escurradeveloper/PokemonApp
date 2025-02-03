//
//  PokemonRouterProtocolSpy.swift
//  PokemonApp
//

@testable import PokemonApp

@MainActor
class PokemonRouterProtocolSpy: PokemonRouterProtocol {
    // MARK: - Properties
    var didRouteToDetailPokemon = false
    var pokemonModel: PokemonModel = PokemonModel(id: 0, name: String.empty)
    
    func routeToDetailPokemon(pokemon: PokemonModel) {
        self.didRouteToDetailPokemon = true
        self.pokemonModel = pokemon
    }  
}
