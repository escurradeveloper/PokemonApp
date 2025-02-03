//
//  PokemonDetailEvolutionGroupView.swift
//  PokemonApp
//

import UIKit

class PokemonDetailEvolutionGroupView: UIView {
    // MARK: - Properties
    private let pokemonModel: PokemonModel
    private let evolutionToPokemon: PokemonModel
    
    private lazy var pokemonEvolutionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var currentPokemonView: PokemonDetailEvolutionView = {
        let view = PokemonDetailEvolutionView(pokemon: pokemonModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var evolutionToPokemonView: PokemonDetailEvolutionView = {
        let view = PokemonDetailEvolutionView(pokemon: evolutionToPokemon)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextEvolutionToPokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.alpha = 0.5
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    init(pokemon: PokemonModel, evolutionTo: PokemonModel) {
        self.pokemonModel = pokemon
        self.evolutionToPokemon = evolutionTo
        super.init(frame: .zero)
        configurePokemonEvolutionStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    private func configurePokemonEvolutionStackView() {
        addSubview(pokemonEvolutionStackView)
        pokemonEvolutionStackView.addArrangedSubview(currentPokemonView)
        pokemonEvolutionStackView.addArrangedSubview(nextEvolutionToPokemonImageView)
        pokemonEvolutionStackView.addArrangedSubview(evolutionToPokemonView)
        NSLayoutConstraint.activate([
            pokemonEvolutionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            pokemonEvolutionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pokemonEvolutionStackView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -10),
            pokemonEvolutionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
    }
}
