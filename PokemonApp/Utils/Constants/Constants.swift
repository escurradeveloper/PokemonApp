//
//  Constants.swift
//  PokemonApp
//

import Foundation
import UIKit

struct Constants {
    struct Urls {
        static let baseUrl = "https://pokeapi.co/api/"
        static let versionApi = "v2"
    }
    
    struct ViewControllers {
        static let listPokemonViewController = "ListPokemonViewController"
        static let detailPokemonViewController = "DetailPokemonViewController"
    }
    
    struct Cells {
        static let listPokemonTableViewCell = "ListPokemonTableViewCell"
    }
    
    struct GlobalSettings {
        static var window = UIWindow()
    }
}
