//
//  PokemonModel.swift
//  PokemonApp
//

import Foundation

final class PokemonModel: Hashable, Sendable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    var imageUrl: URL? {
        URL(string: "\(Constants.Urls.imagePokemonUrl)\(id)\(Constants.ExtensionImage.png)")
    }
    
    var number: String {
        String(format: .formatted, id)
    }
    
    /// for update pokemon details and evolutions
    let detail: PokemonDetailStore = PokemonDetailStore()
    let evolutionChain: PokemonEvolutionChainStore = PokemonEvolutionChainStore()
    
    func getColor() async -> String {
        let pokemonColor = PokemonColor()
        let type = await detail.pokemonDetailModel?.types.first ?? .empty
        let color = pokemonColor.getColor(type: type)
        return color
    }
    
    func getColorByType(type: String) -> String {
        let pokemonColor = PokemonColor()
        return pokemonColor.getColor(type: type)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: PokemonModel, rhs: PokemonModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

struct PokemonEvolutionChainModel {
    let pokemon: PokemonModel
    let evolutions: [PokemonEvolutionChainModel]
}

struct PokemonColor {
    func getColor(type: String) -> String {
        switch type {
        case "bug":
            return "#8BD674"
        case "dark":
            return "#6F6E78"
        case "dragon":
            return "#7383B9"
        case "electric":
            return "#ffd86f"
        case "fairy":
            return "#EBA8C3"
        case "fighting":
            return "#EB4971"
        case "fire":
            return "#fb6c6c"
        case "flying":
            return "#83A2E3"
        case "ghost":
            return "#8571BE"
        case "grass":
            return "#48d0b0"
        case "ground":
            return "#F78551"
        case "ice":
            return "#91D8DF"
        case "normal":
            return "#B5B9C4"
        case "poison":
            return "#9F6E97"
        case "psychic":
            return "#FF6568"
        case "rock":
            return "#D4C294"
        case "steel":
            return "#4C91B2"
        case "water":
            return "#76bdfe"
        default:
            return "F000"
        }
    }
}

/// actor = class
/// for update pokemon details and evolutions
actor
PokemonDetailStore {
    private(set) var pokemonDetailModel: PokemonDetailModel?
    func updatePokemonDetailModel(pokemonDetailModel: PokemonDetailModel) {
        self.pokemonDetailModel = pokemonDetailModel
    }
}

actor
PokemonEvolutionChainStore {
    private(set) var chain: PokemonEvolutionChainModel?
    func updatePokemonEvolutionChainModel(chain: PokemonEvolutionChainModel?) {
        self.chain = chain
    }
}
