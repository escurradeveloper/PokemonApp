//
//  PokemonRepository.swift
//  PokemonApp
//

import CoreData
import Foundation

protocol PokemonCoreDataRepositoryProtocol: Sendable {
    func saveListPokemon(_ pokemons: [PokemonModel]) async
    func getListPokemon() async -> [PokemonModel]
}

final class PokemonCoreDataRepository: PokemonCoreDataRepositoryProtocol {
    @MainActor
    func saveListPokemon(_ pokemons: [PokemonModel]) async {
        do {
            try await PokemonCoreData.shared.clearData()
            for pokemon in pokemons {
                try await savePokemon(pokemon)
            }
            try await PokemonCoreData.shared.saveContext()
        } catch {
            print("Error failed: \(error)")
        }
    }

    @MainActor
    func getListPokemon() async -> [PokemonModel] {
        do {
            let pokemonEntities = try await PokemonCoreData.shared.fetchRequest(PokemonEntity.self)
            let pokemons = await pokemonEntities.transformThread { await $0.convertToModel() }
            return pokemons.sorted(by: { $0.id < $1.id })
        } catch {
            print("Error failed: \(error)")
            return []
        }
    }
    
    @MainActor
    func savePokemon(_ pokemon: PokemonModel) async throws {
        let pokemonEntity = PokemonCoreData.shared.insertManagedObject(PokemonEntity.self)
        pokemonEntity.id = Int16(pokemon.id)
        pokemonEntity.name = pokemon.name
        let detail = await pokemon.detail.detail
        pokemonEntity.weight = Int16(detail?.weight ?? 0)
        pokemonEntity.height = Int16(detail?.height ?? 0)
        if let types = detail?.types {
            for type in types {
                let typeEntity = try await fetchCreateType(name: type)
                pokemonEntity.addToTypes(typeEntity)
                typeEntity.addToPokemons(pokemonEntity)
            }
        }
    }

    @MainActor
    func fetchCreateType(name typeName: String) async throws -> PokemonTypeEntity {
        if let existingType = try await PokemonCoreData.shared.fetchRequest(PokemonTypeEntity.self, predicate: NSPredicate(format: "name == %@", typeName)).first {
            return existingType
        }
        let newTypeEntity =  PokemonCoreData.shared.insertManagedObject(PokemonTypeEntity.self)
        newTypeEntity.name = typeName
        return newTypeEntity
    }
}

extension Sequence {
    func transformThread<T: Sendable>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var results = [T]()
        for element in self {
            try await results.append(transform(element))
        }
        return results
    }
}
