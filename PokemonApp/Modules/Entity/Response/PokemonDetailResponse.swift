//
//  PokemonDetailResponse.swift
//  PokemonApp
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let weight: Int
    let height: Int
    let types: [PokemonTypeResponse]
    
    func convertToModel() -> PokemonDetailModel {
        let types = types.map(\.type.name) //map for transform to model
        return PokemonDetailModel(weight: weight,
                                  height: height,
                                  types: types)
    }
}

struct PokemonTypeResponse: Decodable {
    let type: PokemonTypeValueResponse
}

struct PokemonTypeValueResponse: Decodable {
    let name: String
    let url: URL
}

struct EvolutionChainResponse: Decodable {
    let chain: EvolutionNodeResponse
    
    func convertToModal() -> PokemonEvolutionChainModel {
        chain.convertToModel()
    }
}

struct EvolutionNodeResponse: Decodable {
    let pokemon: PokemonResponse
    let evolvesTo: [EvolutionNodeResponse]
    
    enum CodingKeys: String, CodingKey {
        case pokemon = "species"
        case evolvesTo
    }
    
    func convertToModel() -> PokemonEvolutionChainModel {
        let pokemon = pokemon.convertToModel()
        let evolutionChain = evolvesTo.map { $0.convertToModel()
        }
        return PokemonEvolutionChainModel(pokemon: pokemon, evolutions: evolutionChain)
    }
}
