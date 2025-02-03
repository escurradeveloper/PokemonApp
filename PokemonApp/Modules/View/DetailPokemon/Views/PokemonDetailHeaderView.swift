//
//  PokemonDetailHeaderView.swift
//  PokemonApp
//

import UIKit

class PokemonDetailHeaderView: UIView {
    // MARK: - Properties
    private let pokemonModel: PokemonModel
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var pokemonTypeContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pokemonTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemonModel.number
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemonModel.name.capitalized
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    // MARK: - Init
    init(pokemon: PokemonModel) {
        self.pokemonModel = pokemon
        super.init(frame: .zero)
        configureAddSubView()
        configureConstraints()
        animateView()
        Task {
            await getPokemonType()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    @MainActor
    private func getPokemonType() async {
        let pokemonType = await pokemonModel.detail.pokemonDetailModel?.types ?? []
        pokemonType.forEach { type in
            let color = pokemonModel.getColorByType(type: type)
            let typeColorHex = UIColor(hex: color).saturationColor(by: 0.1)
            let pokemonTypeView = PokemonDetailTypeView(name: type, color: typeColorHex)
            pokemonTypeStackView.addArrangedSubview(pokemonTypeView)
        }
    }
    
    private func configureAddSubView() {
        addSubview(contentStackView)
        addSubview(pokemonNumberLabel)
        contentStackView.addArrangedSubview(pokemonNameLabel)
        contentStackView.addArrangedSubview(pokemonTypeContentView)
        pokemonTypeContentView.addSubview(pokemonTypeStackView)
    }
    
    private func configureConstraints() {
        configurePokemonNumberConstraints()
        configureContentStackViewConstraints()
        configurePokemonTypeStackViewConstraints()   
    }
    
    private func configurePokemonNumberConstraints() {
        NSLayoutConstraint.activate([
            pokemonNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            pokemonNumberLabel.centerYAnchor.constraint(equalTo: pokemonNameLabel.centerYAnchor)])
    }
    
    private func configureContentStackViewConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            contentStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35)])
    }
    
    private func configurePokemonTypeStackViewConstraints() {
        NSLayoutConstraint.activate([
            pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonTypeContentView.topAnchor),
            pokemonTypeStackView.leadingAnchor.constraint(equalTo: pokemonTypeContentView.leadingAnchor),
            pokemonTypeStackView.trailingAnchor.constraint(lessThanOrEqualTo: pokemonTypeContentView.trailingAnchor),
            pokemonTypeStackView.bottomAnchor.constraint(equalTo: pokemonTypeContentView.bottomAnchor)])
    }
    
    private func animateView() {
        self.contentStackView.alpha = 0
        self.pokemonNumberLabel.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn], animations: {
            self.contentStackView.alpha = 1.0
            self.pokemonNumberLabel.alpha = 1.0
            self.layoutIfNeeded()})
    }
}
