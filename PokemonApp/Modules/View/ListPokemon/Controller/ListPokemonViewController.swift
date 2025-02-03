//
//  ListPokemonViewController.swift
//  PokemonApp
//

import UIKit

class ListPokemonViewController: UIViewController {
    // MARK: - Properties
    private var presenter: (PokemonPresenterProtocol & PokemonPresenterVariablesProtocol)
    private var enableSearchBar = UISearchController(searchResultsController: nil)
    
    private lazy var listPokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListPokemonTableViewCell.self, forCellReuseIdentifier: ListPokemonTableViewCell.listPokemonTableViewCell)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var listPokemonDataSource: UITableViewDiffableDataSource<Int, PokemonModel> = {
        UITableViewDiffableDataSource<Int, PokemonModel>(tableView: listPokemonTableView) { tableView, indexPath, pokemon in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListPokemonTableViewCell.listPokemonTableViewCell, for: indexPath) as? ListPokemonTableViewCell
            cell?.configureListPokemonTableViewCell(pokemon: pokemon)
            cell?.selectionStyle = .none
            return cell
        }
    }()
    
    private lazy var dataEmptyView: DataEmptyView = {
        let view = DataEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.touchRetryButton = { [weak self] in
            self?.getListPokemon()
        }
        return view
    }()
    
    // MARK: - Init
    init(presenter: (PokemonPresenterProtocol & PokemonPresenterVariablesProtocol)) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePresenter()
        configureSearchBar()
        configureListPokemonTableView()
        getListPokemon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("pokemon_app", comment: "pokemon_app")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black.withAlphaComponent(0.9)
        configureNavigationController()
        animateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = .empty
    }
    
    // MARK: - Functions
    private func configurePresenter() {
        presenter.loadPokemon =  { [weak self] pokemon in
            guard let welf = self else { return }
            welf.enableSearchBar.searchBar.isUserInteractionEnabled = true
            welf.configureSnapshot(pokemon: pokemon)
        }
        presenter.searchEmptyPokemon = { [weak self] searchEmptyPokemon in
            guard let welf = self else { return }
            welf.showSearchEmptyPokemonView(searchEmptyPokemon)
        }
        presenter.loadProgress = { [weak self] loadProgress in
            guard let welf = self else { return }
            welf.enableSearchBar.searchBar.isUserInteractionEnabled = false
            welf.configureDataEmptyView(false)
            welf.showLoadingView(loadProgress)
        }
        presenter.dataEmpty = { [weak self] in
            guard let welf = self else { return }
            welf.enableSearchBar.searchBar.isUserInteractionEnabled = false
            welf.animateView()
            welf.configureDataEmptyView(true)
        }
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_pokemon", comment: "search_pokemon")
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        enableSearchBar = searchController
    }
    
    private func getListPokemon() {
        Task {
            await presenter.getListPokemon()
        }
    }
    
    private func configureSnapshot(pokemon: [PokemonModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PokemonModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(pokemon)
        listPokemonDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func showSearchEmptyPokemonView(_ show: Bool) {
        if show {
            let emptyView = SearchEmptyPokemonView()
            listPokemonTableView.backgroundView = emptyView
        } else {
            listPokemonTableView.backgroundView = nil
        }
    }
    
    private func showLoadingView(_ loadingShow: Bool) {
        if loadingShow {
            Utils.shared.showProgressView(view: self.view)
        } else {
            Utils.shared.hideProgressView()
        }
    }
    
    private func configureDataEmptyView(_ shouldShow: Bool) {
        if shouldShow {
            dataEmptyView.removeFromSuperview()
            view.addSubview(dataEmptyView)
            NSLayoutConstraint.activate([
                dataEmptyView.topAnchor.constraint(equalTo: view.topAnchor),
                dataEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dataEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                dataEmptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        } else {
            dataEmptyView.removeFromSuperview()
        }
    }
    
    func configureListPokemonTableView() {
        view.backgroundColor = .white
        view.addSubview(listPokemonTableView)
        NSLayoutConstraint.activate([
            listPokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listPokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listPokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listPokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func animateView() {
        self.listPokemonTableView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.listPokemonTableView.alpha = 1.0
            self.view.layoutIfNeeded()})
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.enableSearchBar.searchBar.showsCancelButton = false
        self.view.endEditing(true)
    }
    
    deinit {
        print(": ListPokemonViewController deinit")
    }
}

// MARK: - UITableViewDelegate
extension ListPokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ListPokemonTableViewCell.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToPokemon(pokemonIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

// MARK: - UISearchBarDelegate
extension ListPokemonViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        let cancellButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancellButton.setTitle(NSLocalizedString("cancel_button", comment: "cancel_button"), for: .normal)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.isFirstResponder == true  {
            searchBar.showsCancelButton = true
            searchBar.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = .empty
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return filterSearch(searchBar, filterText: text, range: range)
    }
}

// MARK: - UISearchResultsUpdating
extension ListPokemonViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter.searchPokemon(pokemonName: text)
    }
}
