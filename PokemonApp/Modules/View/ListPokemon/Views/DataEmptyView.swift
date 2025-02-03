//
//  DataEmptyView.swift
//  PokemonApp
//

import UIKit

class DataEmptyView: UIView {
    // MARK: - Properties
    var touchRetryButton: (() -> Void)? = nil
    
    private lazy var descriptionDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("error_description", comment: "error_description")
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("retry_button", comment: "retry_button"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDescriptionLabel()
        configureRetryButton()
        didTapActionRetryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error failed")
    }
    
    // MARK: - Functions
    private func configureDescriptionLabel() {
        addSubview(descriptionDataLabel)
        NSLayoutConstraint.activate([
            descriptionDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        descriptionDataLabel.setLineSpacing(lineHeight: 5)
        descriptionDataLabel.textAlignment = .center
    }
    
    private func configureRetryButton() {
        addSubview(retryButton)
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: descriptionDataLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 200),
            retryButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func didTapActionRetryButton() {
        retryButton.addAction(UIAction { [weak self] _ in
            guard let welf = self else {
                return
            }
            welf.touchRetryButton?()
        }, for: .touchUpInside)
    }
    
    private func animateView() {
        self.descriptionDataLabel.alpha = 0
        self.retryButton.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.descriptionDataLabel.alpha = 1.0
            self.retryButton.alpha = 1.0
            self.layoutIfNeeded()})
    }
}
