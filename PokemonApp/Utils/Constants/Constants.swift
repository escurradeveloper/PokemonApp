//
//  Constants.swift
//  PokemonApp
//

import Foundation
import UIKit

struct Constants {
    struct Urls {
        static let baseUrl = "https://pokeapi.co/api/"
        static let imagePokemonUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork//"
    }
    
    struct ApiVersion {
        static let version = "v2"
    }
    
    struct ExtensionImage {
        static let png = ".png"
    }
    
    struct Cells {
        static let listPokemonTableViewCell = "ListPokemonTableViewCell"
        static let cellHeight = 170
    }
    
    struct Pattern {
        static let characterAllow = "^[A-Za-zÑ-ñ-á-é-í-ó-ú ]+$"
        static let charactersNotAllowed = """
                [$&+€~£¥•¢{}≠´∞,¬÷:;=¿?@.-;#|0123456789'/-_<>^*()-%¡!]""
                """
    }
    
    struct GlobalSettings {
        static var window = UIWindow()
    }
}
