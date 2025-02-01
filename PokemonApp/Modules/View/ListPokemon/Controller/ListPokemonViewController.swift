//
//  ListPokemonViewController.swift
//  PokemonApp
//

import UIKit

class ListPokemonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController")
        let button:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        self.view.backgroundColor = .white
    }
    
    @objc func buttonClicked() {
        print("Button Clicked")
        let coordinator = ListPokemonCoordinator(window: Constants.GlobalSettings.window)
        coordinator.goToDetailPokemon()
    }
    
}
