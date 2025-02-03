//
//  PokemonConfigurator.swift
//  PokemonApp
//

import Foundation
import CoreData

/// Configure data service and data local
struct PokemonConfigurator {
    static func getPokemonService() -> PokemonAPIProtocol {
        return PokemonAPI()
    }
    
    static func getPokemonCoreDataRepository() -> PokemonCoreDataRepositoryProtocol {
        return PokemonCoreDataRepository()
    }
    
    @MainActor
    static func configurePokemonCoreData() {
        let pokemonCoreData = PokemonCoreData.shared
        print("\(pokemonCoreData)")
    }
}
