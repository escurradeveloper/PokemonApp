//
//  DetailPokemonViewController.swift
//  PokemonApp
//

import UIKit

class DetailPokemonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Detail"
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

    }
}
