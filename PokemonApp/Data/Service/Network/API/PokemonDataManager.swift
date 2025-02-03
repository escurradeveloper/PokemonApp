//
//  PokemonDataManager.swift
//  PokemonApp
//

/// Use DataManager for execute all service in this project
/// actor = class
actor
PokemonDataManager {
    private var pokemonModel: [PokemonModel] = []
    private let pokemonAPI: PokemonAPIProtocol

    init(pokemonAPI: PokemonAPIProtocol) {
        self.pokemonAPI = pokemonAPI
    }

    func executeServices() async throws -> [PokemonModel] {
        pokemonModel = try await getListPokemon()
        try await withThrowingTaskGroup(of: Void.self) { group in
            for pokemon in pokemonModel {
                group.addTask {
                    try await self.getPokemonDetail(for: pokemon)
                    try await self.getPokemonEvolutionChain(for: pokemon)
                }
            }
            try await group.waitForAll()
        }
        return pokemonModel
    }

    private func getListPokemon() async throws -> [PokemonModel] {
        let result = await pokemonAPI.getListPokemon()
        switch result {
        case .success(let pokemon):
            return pokemon
        case .failure(let error):
            print("Error failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func getPokemonDetail(for pokemon: PokemonModel) async throws {
        let result = await pokemonAPI.getPokemonDetail(pokemonId: pokemon.id)
        switch result {
        case .success(let pokemonDetail):
            await pokemon.detail.updatePokemonDetailModel(pokemonDetailModel: pokemonDetail)
        case .failure(let error):
            print("Error failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func getPokemonEvolutionChain(for pokemon: PokemonModel) async throws {
        let result = await pokemonAPI.getPokemonEvolutionChain(pokemonId: pokemon.id)
        switch result {
        case .success(let evolutionChain):
            await pokemon.evolutionChain.updatePokemonEvolutionChainModel(chain: evolutionChain)
        case .failure(let error):
            print("Error failed: \(error.localizedDescription)")
            throw error
        }
    }
}
