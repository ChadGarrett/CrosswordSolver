//
//  LoadingViewController.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/11/16.
//

import Material
import UIKit

final class LoadingViewController: UIViewController {

    // MARK: - Setup

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.textDidUpdate()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        self.view.addSubviewAndPinEdgesToSuperview(blurEffectView)

        self.view.addSubview(self.loadingSpinner)
        self.loadingSpinner.autoCenterInSuperview()

        self.view.addSubview(self.lblLoaderText)
        self.lblLoaderText.autoPinEdge(.top, to: .bottom, of: self.loadingSpinner, withOffset: Stylesheet.Padding.m)
        self.lblLoaderText.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadingSpinner.startAnimating()
    }

    // MARK: - Properties

    enum Text {
        case loading
        case saving

        var text: String {
            switch self {
            case .loading: return "Loading..."
            case .saving: return "Saving..."
            }
        }
    }

    internal var text: Text = .loading {
        didSet { self.textDidUpdate() }
    }

    private func textDidUpdate() {
        self.lblLoaderText.attributedText = .init(
            string: self.text.text,
            attributes: Stylesheet.Text.loader)
    }

    // MARK: - Subviews

    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()

        spinner.style = .large
        spinner.color = Color.lightBlue.accent4

        // Center in the screen
        spinner.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]

        return spinner
    }()

    private lazy var lblLoaderText = UILabel()

    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.alpha = 0.8

        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]

        return blurEffectView
    }()
}
