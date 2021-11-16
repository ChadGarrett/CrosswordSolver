//
//  BaseViewController.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import UIKit

class BaseViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupView()
        self.view.backgroundColor = .systemGray6
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func setupView() {
        // Subclasses to override
    }

    // MARK: Properties

    private lazy var loader = LoadingViewController()

    // MARK: Helpers

    internal func route(to controller: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(controller, animated: animated)
        }
    }

    /// Displays a full screen loader to indicate to the user something is happening
    /// - Parameter onCompletion: Callback that is fired once the loader is showing
    internal func displayLoader(_ onCompletion: @escaping () -> Void) {
        let loader = loader
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.present(loader, animated: true, completion: onCompletion)
        }
    }

    /// Hides the full screen loader
    /// - Parameter onCompletion: Callback that is fired once the loader is fully dismissed
    internal func hideLoader(_ onCompletion: @escaping() -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.loader.dismiss(animated: true, completion: onCompletion)
        }
    }

    func setBackgroundImage(imageName: String) {
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = backgroundImage
        self.view.insertSubview(backgroundImageView, at: 0)
    }
}
