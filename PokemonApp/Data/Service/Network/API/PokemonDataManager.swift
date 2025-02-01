//
//  PokemonDataManager.swift
//  PokemonApp
//

actor
PokemonDataManager {
    private var pokemonModel: [PokemonModel] = []
    private let pokemonAPI: PokemonAPIProtocol

    init(pokemonAPI: PokemonAPIProtocol) {
        self.pokemonAPI = pokemonAPI
    }

    func executeServices(numberOfPokemons: Int) async throws -> [PokemonModel] {
        pokemonModel = try await getListPokemon(numberOfPokemons: numberOfPokemons)
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

    private func getListPokemon(numberOfPokemons: Int) async throws -> [PokemonModel] {
        let result = await pokemonAPI.getListPokemon(limit: numberOfPokemons, offset: 0)
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
            await pokemon.detail.updatePokemonDetailModel(detail: pokemonDetail)
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
