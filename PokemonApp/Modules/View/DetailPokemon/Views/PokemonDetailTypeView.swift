//
//  PokemonDetailTypeView.swift
//  PokemonApp
//

import UIKit

class PokemonDetailTypeView: UIView {
    // MARK: - Properties
    private let name: String
    private let color: UIColor
    
    private lazy var typePokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name.capitalized
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Init
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
        super.init(frame: .zero)
        configureTypePokemonNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func configureTypePokemonNameLabel() {
        backgroundColor = color
        addSubview(typePokemonNameLabel)
        NSLayoutConstraint.activate([
            typePokemonNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            typePokemonNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            typePokemonNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            typePokemonNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }
}
