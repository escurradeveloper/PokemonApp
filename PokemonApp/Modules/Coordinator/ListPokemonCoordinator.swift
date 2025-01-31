//
//  ListPokemonCoordinator.swift
//  PokemonApp
//

import UIKit

@MainActor
class ListPokemonCoordinator {
    private let window: UIWindow

    private var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }

    init(window: UIWindow) {
        self.window = window
    }

    func initListPokemon() {
        window.rootViewController = UINavigationController(rootViewController: ListPokemonViewController())
        window.makeKeyAndVisible()
    }
    
    func goToDetailPokemon() {
        let viewController = DetailPokemonViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
