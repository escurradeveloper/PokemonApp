//
//  PokemonInteractor.swift
//  PokemonApp
//

import Foundation

protocol PokemonInteractorProtocol: Sendable {
    func executeServices() async -> [PokemonModel]
}

struct PokemonInteractor: PokemonInteractorProtocol {
    private let pokemonDataManager: PokemonDataManager
    private let pokemonRepository: PokemonCoreDataRepositoryProtocol
    
    init(pokemonDataManager: PokemonDataManager, pokemonRepository: PokemonCoreDataRepositoryProtocol) {
        self.pokemonDataManager = pokemonDataManager
        self.pokemonRepository = pokemonRepository
    }
    
    func executeServices() async -> [PokemonModel] {
        let localPokemon = await pokemonRepository.getListPokemon()
        do {
            let pokemon = try await pokemonDataManager.executeServices()
            await pokemonRepository.saveListPokemon(pokemon)
            return pokemon
        } catch {
            print("Error failed: \(error.localizedDescription)")
            return localPokemon
        }
    }
}
