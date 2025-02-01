//
//  Utils.swift
//  PokemonApp
//

import Foundation
import UIKit

// MARK: - Utils
/// Use Singleton pattern
class Utils {
    static let shared = Utils()
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    private init() {}
    
    func showProgressView(view: UIView) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.gray
        containerView.layer.opacity = 0.5
        progressView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        progressView.center = window.center
        progressView.backgroundColor = UIColor.white
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.color = UIColor.gray
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
