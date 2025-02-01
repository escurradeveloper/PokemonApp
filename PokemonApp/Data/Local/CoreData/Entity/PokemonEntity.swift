//
//  PokemonEntity.swift
//  PokemonApp
//

extension PokemonEntity: @unchecked Sendable {
    func convertToModel() async -> PokemonModel {
        let types = (types)?
            .compactMap { $0 as? PokemonTypeEntity }
            .compactMap { $0.name } ?? []
        let detail = PokemonDetailModel(weight: Int(weight), height: Int(height), types: types)
        let pokemon = PokemonModel(id: Int(id), name: name ?? .empty)
        await pokemon.detail.updatePokemonDetailModel(detail: detail)
        return pokemon
    }
}

extension PokemonTypeEntity: @unchecked Sendable {
    
}
