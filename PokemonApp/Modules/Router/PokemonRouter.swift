//
//  PokemonRouter.swift
//  PokemonApp
//

import UIKit

@MainActor
protocol PokemonRouterProtocol: AnyObject {
    func routeToDetailPokemon(pokemon: PokemonModel)
}

class PokemonRouter: PokemonRouterProtocol {
    private let window: UIWindow
    private var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    /// Use Dependency Injection Pattern
    func configureListPokemon() {
        let pokemonApiService = PokemonConfigurator.getPokemonService()
        let pokemonDataManager = PokemonDataManager(pokemonAPI: pokemonApiService)
        let repository = PokemonConfigurator.getPokemonCoreDataRepository()
        let interactor = PokemonInteractor(pokemonDataManager: pokemonDataManager, pokemonRepository: repository)
        let router = PokemonRouter(window: self.window)
        let presenter = PokemonPresenter(interactor: interactor, router: router)
        let viewController = ListPokemonViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func routeToDetailPokemon(pokemon: PokemonModel) {
        let viewController = DetailPokemonViewController(pokemon: pokemon)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
