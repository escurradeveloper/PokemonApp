//
//  UISearchBarExtensions.swift
//  PokemonApp
//

import Foundation
import UIKit

extension UISearchBarDelegate {
    func filterSearch(_ searchBar: UISearchBar, filterText text: String, range: NSRange) -> Bool {
        let filterText = Constants.Pattern.characterAllow
        let specialCharacters = Constants.Pattern.charactersNotAllowed
        let numberOfChars = text.count
        do {
            let expression = try NSRegularExpression(pattern: filterText, options: [])
            let makeRange = NSRange(location: 0, length: numberOfChars)
            if expression.firstMatch(in: text, options: [], range: makeRange) != nil || (numberOfChars == 0) {
                return numberOfChars < 60
            } else {
                let charSet = CharacterSet(charactersIn: specialCharacters)
                guard text.rangeOfCharacter(from: charSet.inverted) != nil else {
                    return false
                }
                return true
            }
        } catch {
            return false
        }
    }
}
