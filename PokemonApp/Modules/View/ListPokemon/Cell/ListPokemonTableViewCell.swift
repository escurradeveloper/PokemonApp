//
//  ListPokemonTableViewCell.swift
//  PokemonApp
//

import UIKit
import AlamofireImage

class ListPokemonTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let listPokemonTableViewCell = Constants.Cells.listPokemonTableViewCell
    static let cellHeight = Constants.Cells.cellHeight
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 28
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 10
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.layer.opacity = 0.5
        return label
    }()
    
    private lazy var namePokemonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var numberPokemonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.layer.opacity = 0.5
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 15
        configureSubView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Lifecyle
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    // MARK: - Functions
    public func configureListPokemonTableViewCell(pokemon: PokemonModel) {
        titleLabel.text = NSLocalizedString("title_pokemon", comment: "title_pokemon")
        namePokemonLabel.text = pokemon.name.capitalized
        numberPokemonLabel.text = pokemon.number
        guard let image = pokemon.imageUrl else {
            return
        }
        pokemonImageView.af.setImage(
            withURL: image,
            imageTransition: .flipFromTop(0.5))
        Task {
            await getBackogrundColor(pokemon: pokemon)
        }
    }
    
    @MainActor
    private func getBackogrundColor(pokemon: PokemonModel) async {
        let colorHex = await pokemon.getColor()
        cardView.backgroundColor = UIColor(hex: colorHex)
    }
    
    private func configureSubView() {
        contentView.addSubview(cardView)
        cardView.addSubview(pokemonImageView)
        cardView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(namePokemonLabel)
        contentStackView.addArrangedSubview(numberPokemonLabel)
        cardView.bringSubviewToFront(pokemonImageView)
    }
    
    private func configureConstraints() {
        configureCardViewConstraints()
        configureContentStackViewConstraints()
        configurePokemonImageViewConstraints()
    }
    
    private func configureCardViewConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureContentStackViewConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 6)])
    }
    
    private func configurePokemonImageViewConstraints() {
        NSLayoutConstraint.activate([
            pokemonImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -15),
            pokemonImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 148),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 148)])
    }
}
