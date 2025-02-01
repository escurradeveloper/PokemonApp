//
//  PokemonPresenter.swift
//  PokemonApp
//

@MainActor
protocol PokemonPresenterProtocol {
    func getListPokemon() async
    func searchPokemon(name: String)
    func selectPokemon(index: Int)
    var loadPokemon: (([PokemonModel]) -> Void)? { get set }
    var searchEmptyPokemon: ((Bool) -> Void)? { get set }
    var loadProgress: ((Bool) -> Void)? { get set }
    var dataEmpty: (() -> Void)? { get set }
}

class PokemonPresenter: PokemonPresenterProtocol {
    var loadPokemon: (([PokemonModel]) -> Void)? = nil
    var searchEmptyPokemon: ((Bool) -> Void)? = nil
    var loadProgress: ((Bool) -> Void)? = nil
    var dataEmpty: (() -> Void)? = nil
    private var listPokemon: [PokemonModel] = []
    private var arrayFilterPokemon: [PokemonModel] = []
    private let pokemonInteractor: PokemonInteractorProtocol
    
    init(pokemonInteractor: PokemonInteractorProtocol) {
        self.pokemonInteractor = pokemonInteractor
    }
    
    func getListPokemon() async {
        loadProgress?(true)
        listPokemon = await pokemonInteractor.executeServices()
        loadProgress?(false)
        if listPokemon.isEmpty {
            dataEmpty?()
        } else {
            loadPokemon?(listPokemon)
            arrayFilterPokemon = listPokemon
        }
    }
    
    func searchPokemon(name: String) {
        if name.isEmpty {
            listPokemon = arrayFilterPokemon
            searchEmptyPokemon?(false)
        } else {
            let filteredPokemon = arrayFilterPokemon.filter { $0.name.lowercased().contains(name.lowercased()) }
            listPokemon = filteredPokemon
            searchEmptyPokemon?(filteredPokemon.isEmpty)
        }
        loadPokemon?(listPokemon)
    }
    
    func selectPokemon(index: Int) {
        guard index >= 0 && index < listPokemon.count else {
            return
        }
        let pokemon = listPokemon[index]
        print(pokemon)
    }
}
