//
//  PokemonDetailEvolutionView.swift
//  PokemonApp
//

import UIKit
import AlamofireImage

class PokemonDetailEvolutionView : UIView {
    // MARK: - Properties
    private let pokemonModel: PokemonModel
    
    private lazy var pokemonEvolutionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let image = pokemonModel.imageUrl else {
            return imageView
        }
        imageView.af.setImage(
            withURL: image,
            placeholderImage: UIImage(systemName: "photo.artframe.circle")?.withTintColor(.gray),
            imageTransition: .flipFromBottom(0.3))
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemonModel.number
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemonModel.name.capitalized
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    init(pokemon: PokemonModel) {
        self.pokemonModel = pokemon
        super.init(frame: .zero)
        configurePokemonEvolutionStackView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    private func configurePokemonEvolutionStackView() {
        addSubview(pokemonEvolutionStackView)
        pokemonEvolutionStackView.addArrangedSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        pokemonEvolutionStackView.addArrangedSubview(pokemonNumberLabel)
        pokemonEvolutionStackView.setCustomSpacing(1, after: pokemonNumberLabel)
        pokemonEvolutionStackView.addArrangedSubview(pokemonNameLabel)
        NSLayoutConstraint.activate([
            pokemonEvolutionStackView.topAnchor.constraint(equalTo: topAnchor),
            pokemonEvolutionStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonEvolutionStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -14),
            pokemonEvolutionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
