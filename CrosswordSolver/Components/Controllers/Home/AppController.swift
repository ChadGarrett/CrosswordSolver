//
//  AppController.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import Material
import UIKit

class AppController: BaseViewController {

    // MARK: - Setup

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = .systemBackground
        self.title = "Crossword Solver"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override final func setupView() {
        super.setupView()

        self.view.addSubview(self.vwCard)

        self.vwCard.autoAlignAxis(toSuperviewAxis: .horizontal)
        self.vwCard.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.vwCard.addSubview(self.lblCompleteHeading)
        self.vwCard.addSubview(self.lblCompleteDescription)
        self.vwCard.addSubview(self.btnComplete)

        self.lblCompleteHeading.autoPinEdge(toSuperviewSafeArea: .top, withInset: Stylesheet.Padding.m)
        self.lblCompleteHeading.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.lblCompleteDescription.autoPinEdge(.top, to: .bottom, of: self.lblCompleteHeading, withOffset: Stylesheet.Padding.s)
        self.lblCompleteDescription.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.btnComplete.autoPinEdge(.top, to: .bottom, of: self.lblCompleteDescription, withOffset: Stylesheet.Padding.m)
        self.btnComplete.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom], withInset: Stylesheet.Padding.s)

        self.setBackgroundImage(imageName: "pattern_background")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.checkWordDatabaseIsPopulated {
            DispatchQueue.main.async {
                if self.vwCard.isHidden {
                    UIView.transition(with: self.vwCard, duration: 0.3, options: .transitionCrossDissolve) {
                        self.vwCard.isHidden = false
                    }
                }
            }
        }
    }

    // MARK: - Properties

    private var didCheckPopulation: Bool = false

    // MARK: - Subviews

    private lazy var vwCard: CardView = {
        let cardView = CardView()
        cardView.isHidden = true
        return cardView
    }()

    private lazy var lblCompleteHeading: UILabel = {
        let label = UILabel()
        label.attributedText = .init(
            string: "Complete the word",
            attributes: Stylesheet.Text.title)
        return label
    }()

    private lazy var lblCompleteDescription: UILabel = {
        let label = UILabel()
        label.attributedText = .init(
            string: "Enter the characters of the word that you do know, adjust the length of the word to the number of blocks and search to find possible words that fit.",
            attributes: Stylesheet.Text.heading_1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var btnComplete: FlatButton = {
        let button = FlatButton()
        button.pulseColor = .white
        button.backgroundColor = Color.lightBlue.accent4
        button.setTitle("Begin", for: .normal)
        button.addTarget(self, action: #selector(onComplete), for: .touchUpInside)
        button.setTitle("Please wait while we load", for: .disabled)
        return button
    }()
}

// MARK: - Actions

extension AppController {
    @objc private func onSearch() {
        self.route(to: SearchController())
    }

    @objc private func onComplete() {
        self.route(to: CompleteWordController())
    }

    /// Checks the word database is populated and completes once done
    private func checkWordDatabaseIsPopulated(_ onCompletion: @escaping () -> Void) {
        guard !self.didCheckPopulation else {
            onCompletion()
            return
        }

        self.displayLoader {
            try? RealmManager.instance.loadDictionaryIntoRealm {
                self.didCheckPopulation = true
                self.hideLoader {
                    onCompletion()
                }
            }
        }
    }
}
