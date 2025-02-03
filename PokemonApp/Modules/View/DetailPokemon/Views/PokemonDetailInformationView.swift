//
//  PokemonDetailInformationView.swift
//  PokemonApp
//

import UIKit

class PokemonDetailInformationView: UIView {
    // MARK: - Propterties
    private lazy var backgroundGeneralView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.shadowRadius = 26
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 11)
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private lazy var pokemonInformationHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var pokemonHeightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var pokemonWeightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var titleHeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("height_pokemon", comment: "height_pokemon")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var titleWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("weight_pokemon", comment: "weight_pokemon")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var pokemonHeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configurePokemonInformationStackView()
        animateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    public func configureInformationCardView(weight: Int, height: Int, color: UIColor?) {
        guard let colorText = color else {
            return
        }
        pokemonHeightLabel.text = "\(Double(height) / 10) m"
        pokemonWeightLabel.text = "\(Double(weight) / 10) kg"
        titleHeightLabel.textColor = colorText
        titleWeightLabel.textColor = colorText
    }
    
    private func configurePokemonInformationStackView() {
        addSubview(backgroundGeneralView)
        backgroundGeneralView.addSubview(pokemonInformationHorizontalStackView)
        pokemonInformationHorizontalStackView.addArrangedSubview(pokemonHeightStackView)
        pokemonInformationHorizontalStackView.addArrangedSubview(pokemonWeightStackView)
        NSLayoutConstraint.activate([
            backgroundGeneralView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundGeneralView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            backgroundGeneralView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            backgroundGeneralView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundGeneralView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            pokemonInformationHorizontalStackView.topAnchor.constraint(equalTo: backgroundGeneralView.topAnchor, constant: 8),
            pokemonInformationHorizontalStackView.leadingAnchor.constraint(equalTo: backgroundGeneralView.leadingAnchor),
            pokemonInformationHorizontalStackView.trailingAnchor.constraint(equalTo: backgroundGeneralView.trailingAnchor),
            pokemonInformationHorizontalStackView.bottomAnchor.constraint(equalTo: backgroundGeneralView.bottomAnchor, constant: -8)])
        pokemonHeightStackView.addArrangedSubview(titleHeightLabel)
        pokemonHeightStackView.addArrangedSubview(pokemonHeightLabel)
        pokemonWeightStackView.addArrangedSubview(titleWeightLabel)
        pokemonWeightStackView.addArrangedSubview(pokemonWeightLabel)
    }
    
    private func animateView() {
        self.backgroundGeneralView.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseIn], animations: {
            self.backgroundGeneralView.alpha = 1.0
            self.backgroundGeneralView.layer.cornerRadius = 1
            self.layoutIfNeeded()})
    }
}
