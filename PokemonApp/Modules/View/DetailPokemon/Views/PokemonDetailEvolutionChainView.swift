//
//  PokemonDetailEvolutionChainView.swift
//  PokemonApp
//

import UIKit

class PokemonDetailEvolutionChainView: UIView {
    // MARK: - Properties
    private let pokemonModel: PokemonModel
    
    private lazy var evolutionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("title_evolutions", comment: "title_evolutions")
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Init
    init(pokemon: PokemonModel) {
        self.pokemonModel = pokemon
        super.init(frame: .zero)
        configureTitleLabel()
        configureContentStackView()
        animateView()
        Task {
            let evolutionChain = await pokemon.evolutionChain.chain
            let color = await pokemon.getColor()
            evolutionTitleLabel.textColor = UIColor(hex: color)
            await configurePokemonEvolutionChain(evolutionChain: evolutionChain)
            if contentStackView.arrangedSubviews.isEmpty {
                let label = UILabel()
                label.numberOfLines = 0
                label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                label.textColor = .gray
                label.text = NSLocalizedString("without_any_evolution", comment: "without_any_evolution")
                contentStackView.addArrangedSubview(label)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    private func configurePokemonEvolutionChain(evolutionChain: PokemonEvolutionChainModel?) async {
        guard let evolutionChain, !evolutionChain.evolutions.isEmpty else { return }
        let currentPokemon = evolutionChain.pokemon
        for evolution in evolutionChain.evolutions {
            let evolutionGroup = PokemonDetailEvolutionGroupView(pokemon: currentPokemon, evolutionTo: evolution.pokemon)
            contentStackView.addArrangedSubview(evolutionGroup)
            await configurePokemonEvolutionChain(evolutionChain: evolution)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(evolutionTitleLabel)
        NSLayoutConstraint.activate([
            evolutionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            evolutionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            evolutionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    private func configureContentStackView() {
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: evolutionTitleLabel.bottomAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func animateView() {
        evolutionTitleLabel.alpha = 0
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseIn], animations: {
            self.evolutionTitleLabel.alpha = 1.0
            self.layoutIfNeeded()})
        contentStackView.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn], animations: {
            self.contentStackView.alpha = 1.0
            self.layoutIfNeeded()})
    }
}
