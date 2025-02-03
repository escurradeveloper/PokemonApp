//
//  PokemonMock.swift
//  PokemonApp
//

@testable import PokemonApp

struct PokemonMock {
    static func mew() -> PokemonModel {
        return PokemonModel(id: 1, name: "Mew")
    }
    
    static func charmander() -> PokemonModel {
        return PokemonModel(id: 1, name: "Charmander")
    }
    
    static var mockPokemonData = """
        {
            "results": [
                { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/" }
            ]
        }
        """
    
    static var mockPokemonDetailData = """
            {
                "id": 1,
                "name": "bulbasaur",
                "height": 7,
                "weight": 69,
                "types": [
                    { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } },
                    { "slot": 2, "type": { "name": "poison", "url": "https://pokeapi.co/api/v2/type/4/" } }
                ]
            }
            """
}
