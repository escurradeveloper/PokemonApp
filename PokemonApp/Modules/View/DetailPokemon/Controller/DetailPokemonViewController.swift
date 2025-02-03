//
//  DetailPokemonViewController.swift
//  PokemonApp
//

import UIKit
import AlamofireImage

class DetailPokemonViewController: UIViewController {
    // MARK: - Properties
    private let pokemonModel: PokemonModel
    
    private lazy var pokemonDetailHeaderView: PokemonDetailHeaderView = {
        let view = PokemonDetailHeaderView(pokemon: pokemonModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundGeneralView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let image = pokemonModel.imageUrl else {
            return imageView
        }
        imageView.af.setImage(
            withURL: image,
            imageTransition: .flipFromTop(0.5))
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var generalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var pokemonDetailInformationView: PokemonDetailInformationView = {
        let view = PokemonDetailInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pokemonDetailEvolutionChainView: PokemonDetailEvolutionChainView = {
        let view = PokemonDetailEvolutionChainView(pokemon: pokemonModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(disabledButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(pokemon: PokemonModel) {
        self.pokemonModel = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("title_pokemon", comment: "title_pokemon")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        Task {
            await configureBackgroundGeneralInformationView()
        }
        configurePokemonDetailHeaderView()
        configureBackgroundGeneralView()
        configureGeneralScollView()
        configureContentStackView()
        animateView()
        disabledButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Functions
    private func configureBackgroundGeneralInformationView() async {
        let color = await pokemonModel.getColor()
        view.backgroundColor = UIColor(hex: color)
        if let detail = await pokemonModel.detail.pokemonDetailModel {
            pokemonDetailInformationView.configureInformationCardView(weight: detail.weight,
                                                           height: detail.height,
                                                           color: view.backgroundColor)
        }
    }
    
    private func configurePokemonDetailHeaderView() {
        view.addSubview(pokemonDetailHeaderView)
        NSLayoutConstraint.activate([
            pokemonDetailHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonDetailHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func configureBackgroundGeneralView() {
        view.addSubview(backgroundGeneralView)
        view.addSubview(backgroundContentView)
        view.addSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            backgroundGeneralView.topAnchor.constraint(equalTo: pokemonDetailHeaderView.bottomAnchor , constant: 80),
            pokemonImageView.topAnchor.constraint(equalTo: backgroundGeneralView.topAnchor , constant: -120),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 250),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 250),
            backgroundGeneralView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGeneralView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundGeneralView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundContentView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
            backgroundContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureGeneralScollView() {
        backgroundContentView.addSubview(generalScrollView)
        NSLayoutConstraint.activate([
            generalScrollView.topAnchor.constraint(equalTo: backgroundContentView.topAnchor),
            generalScrollView.leadingAnchor.constraint(equalTo: backgroundContentView.leadingAnchor),
            generalScrollView.trailingAnchor.constraint(equalTo: backgroundContentView.trailingAnchor),
            generalScrollView.bottomAnchor.constraint(equalTo: backgroundContentView.bottomAnchor),])
    }
    
    private func configureContentStackView() {
        generalScrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: generalScrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: generalScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: generalScrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: generalScrollView.bottomAnchor),
            generalScrollView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)])
        contentStackView.addArrangedSubview(pokemonDetailInformationView)
        contentStackView.addArrangedSubview(pokemonDetailEvolutionChainView)
    }
    
    private func animateView() {
        self.pokemonImageView.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn], animations: {
            self.pokemonImageView.alpha = 1.0})
    }
    
    @objc private func disabledButton() {
        rightBarButton.isUserInteractionEnabled = false
    }
    
    deinit {
        print(": DetailPokemonViewController deinit")
    }
}
