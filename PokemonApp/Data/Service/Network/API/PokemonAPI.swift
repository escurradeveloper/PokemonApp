//
//  PokemonAPI.swift
//  PokemonApp
//

import Foundation

protocol PokemonAPIProtocol: Sendable {
    func getListPokemon() async -> Result<[PokemonModel], Error>
    func getPokemonDetail(pokemonId: Int) async -> Result<PokemonDetailModel, Error>
    func getPokemonEvolutionChain(pokemonId: Int) async -> Result<PokemonEvolutionChainModel, Error>
}

struct PokemonAPI: PokemonAPIProtocol {
    private let session: URLSessionProtocol
    
    enum Services {
        case getListPokemon
        case getDetailPokemon(id: Int)
        case getSpecies(id: Int)
        
        var baseUrl: String {
            Constants.Urls.baseUrl
        }
        var versionApi: String {
            Constants.ApiVersion.version
        }
        
        var path: String {
            switch self {
            case .getListPokemon:
                return  "pokemon?limit=151"
            case .getDetailPokemon(id: let id):
                return "pokemon/\(id)"
            case .getSpecies(id: let id):
                return "pokemon-species/\(id)"
            }
        }
        
        var endpointURLFull: URL? { URL(string: baseUrl + versionApi + "/" + path) }
    }
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(from url: URL?) async throws -> Data {
        guard let url = url else {
            throw URLError(.badURL)
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    func getListPokemon() async -> Result<[PokemonModel], Error> {
        do {
            let data = try await fetchData(from: PokemonAPI.Services.getListPokemon.endpointURLFull)
            let decoder = JSONDecoder()
            let pokemonResponse = try decoder.decode(ListPokemonResponse.self, from: data)
            return .success(pokemonResponse.convertToModel())
        } catch {
            print("Error failed: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func getPokemonDetail(pokemonId: Int) async -> Result<PokemonDetailModel, Error> {
        do {
            let data = try await fetchData(from: PokemonAPI.Services.getDetailPokemon(id: pokemonId).endpointURLFull)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemonDetailResponse = try decoder.decode(PokemonDetailResponse.self, from: data)
            return .success(pokemonDetailResponse.convertToModel())
        } catch {
            print("Error failed: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func getPokemonSpecies(pokemonId: Int) async throws -> PokemonSpeciesResponse {
        do {
            let data = try await fetchData(from: PokemonAPI.Services.getSpecies(id: pokemonId).endpointURLFull)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let speciesResponse = try decoder.decode(PokemonSpeciesResponse.self, from: data)
            return speciesResponse
        } catch {
            print("Error failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getPokemonEvolutionChain(pokemonId: Int) async -> Result<PokemonEvolutionChainModel, Error> {
        do {
            let species = try await getPokemonSpecies(pokemonId: pokemonId)
            let data = try await fetchData(from: URL(string: species.evolutionChain.url))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemonEvolutionChainResponse = try decoder.decode(EvolutionChainResponse.self, from: data)
            return .success(pokemonEvolutionChainResponse.convertToModal())
        } catch {
            print("Error failed: \(error.localizedDescription)")
            return .failure(error)
        }
    }
}
