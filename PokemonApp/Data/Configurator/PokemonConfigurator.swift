//
//  PokemonConfigurator.swift
//  PokemonApp
//

import Foundation
import CoreData

struct PokemonConfigurator {
    static func getPokemonService() -> PokemonAPIProtocol {
        return PokemonAPI()
    }
    
    static func getPokemonCoreDataRepository() -> PokemonCoreDataRepositoryProtocol {
        return PokemonCoreDataRepository()
    }
    
    @MainActor
    static func setupPokemonCoreData() {
        let pokemonCoreData = PokemonCoreData.shared
        print("\(pokemonCoreData)")
    }
}
