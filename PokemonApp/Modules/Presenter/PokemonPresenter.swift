//
//  PokemonPresenter.swift
//  PokemonApp
//

/// Interface Segregation in protocols
@MainActor
protocol PokemonPresenterVariablesProtocol {
    var loadPokemon: (([PokemonModel]) -> Void)? { get set }
    var searchEmptyPokemon: ((Bool) -> Void)? { get set }
    var loadProgress: ((Bool) -> Void)? { get set }
    var dataEmpty: (() -> Void)? { get set }
}

@MainActor
protocol PokemonPresenterProtocol {
    func getListPokemon() async
    func searchPokemon(pokemonName: String)
    func goToPokemon(pokemonIndex: Int)
}

class PokemonPresenter: PokemonPresenterProtocol, PokemonPresenterVariablesProtocol {
    var loadPokemon: (([PokemonModel]) -> Void)? = nil
    var searchEmptyPokemon: ((Bool) -> Void)? = nil
    var loadProgress: ((Bool) -> Void)? = nil
    var dataEmpty: (() -> Void)? = nil
    private var listPokemon: [PokemonModel] = []
    private var arrayFilterPokemon: [PokemonModel] = []
    private let interactor: PokemonInteractorProtocol
    private let router: PokemonRouterProtocol
    
    init(interactor: PokemonInteractorProtocol, router: PokemonRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getListPokemon() async {
        loadProgress?(true)
        listPokemon = await interactor.executeServices()
        loadProgress?(false)
        if listPokemon.isEmpty {
            dataEmpty?()
        } else {
            loadPokemon?(listPokemon)
            arrayFilterPokemon = listPokemon
        }
    }
    
    func searchPokemon(pokemonName: String) {
        if pokemonName.isEmpty {
            listPokemon = arrayFilterPokemon
            searchEmptyPokemon?(false)
        } else {
            let filteredPokemon = arrayFilterPokemon.filter { $0.name.lowercased().contains(pokemonName.lowercased()) }
            listPokemon = filteredPokemon
            searchEmptyPokemon?(filteredPokemon.isEmpty)
        }
        loadPokemon?(listPokemon)
    }
    
    func goToPokemon(pokemonIndex: Int) {
        guard pokemonIndex >= 0 && pokemonIndex < listPokemon.count else {
            return
        }
        let pokemon = listPokemon[pokemonIndex]
        router.routeToDetailPokemon(pokemon: pokemon)
    }
}
