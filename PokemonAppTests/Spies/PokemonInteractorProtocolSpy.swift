//
//  PokemonInteractorProtocolSpy.swift
//  PokemonApp
//

@testable import PokemonApp

@MainActor
class PokemonInteractorProtocolSpy: PokemonInteractorProtocol {
    // MARK: - Properties
    var didExecuteServices = false
    var pokemonModel: [PokemonModel]? = []
    
    // MARK: - Functions
    func executeServices() async -> [PokemonModel] {
        self.didExecuteServices = true
        return pokemonModel ?? []
    }
}
