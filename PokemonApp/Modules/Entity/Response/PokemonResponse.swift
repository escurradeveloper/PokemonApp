//
//  PokemonResponse.swift
//  PokemonApp
//

import Foundation

struct ListPokemonResponse: Decodable {
    let results: [PokemonResponse]
    
    func convertToModel() -> [PokemonModel] {
        results.map {
            $0.convertToModel() /// map for transform to model
        }
    }
}

struct PokemonResponse: Decodable {
    let id: Int
    let name: String
    let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)
        guard let extractedID = PokemonResponse.extractPokemonID(from: url) else {
            throw DecodingError.dataCorruptedError(forKey: .url, in: container, debugDescription: "Invalid URL: \(url)")
        }
        id = extractedID
    }
    
    static func extractPokemonID(from url: URL) -> Int? {
        let components = url.path.split(separator: "/")
        guard let lastComponent = components.last, let id = Int(lastComponent) else {
            return nil
        }
        return id
    }
    
    func convertToModel() -> PokemonModel {
        PokemonModel(id: id, name: name)
    }
}

struct PokemonSpeciesResponse: Decodable {
    let evolutionChain: EvolutionChainURLResponse
}

struct EvolutionChainURLResponse: Decodable {
    let url: String
}
