//
//  SearchEmptyPokemonView.swift
//  PokemonApp
//

import UIKit

class SearchEmptyPokemonView: UIView {
    // MARK: - Properties
    private lazy var descriptionEmptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .pokemonCapsule
        return imageView
    }()
    
    private lazy var descriptionEmptyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("list_empty", comment: "list_empty")
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        configureDescriptionLabel()
        animateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    private func configureImageView() {
        addSubview(descriptionEmptyImageView)
        NSLayoutConstraint.activate([
            descriptionEmptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionEmptyImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            descriptionEmptyImageView.widthAnchor.constraint(equalToConstant: 90),
            descriptionEmptyImageView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionEmptyLabel)
        NSLayoutConstraint.activate([
            descriptionEmptyLabel.topAnchor.constraint(equalTo: descriptionEmptyImageView.bottomAnchor, constant: 20),
            descriptionEmptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionEmptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        descriptionEmptyLabel.setLineSpacing(lineHeight: 5)
        descriptionEmptyLabel.textAlignment = .center
    }
    
    private func animateView() {
        self.descriptionEmptyImageView.alpha = 0
        self.descriptionEmptyLabel.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            self.descriptionEmptyImageView.alpha = 1.0
            self.descriptionEmptyLabel.alpha = 1.0
            self.layoutIfNeeded()})
    }
}
