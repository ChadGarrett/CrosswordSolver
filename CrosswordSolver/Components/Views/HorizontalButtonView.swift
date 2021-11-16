//
//  HorizontalButtonView.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/30.
//

import UIKit

final class HorizontalButtonView: BaseView {
    init(button: UIView) {
        self.button = button
        super.init(frame: .zero)
    }

    convenience init(leftView: UIView, rightView: UIView?) {
        let buttonsView = UIStackView()
        buttonsView.backgroundColor = .clear
        buttonsView.axis = .horizontal
        buttonsView.alignment = .fill
        buttonsView.spacing = Stylesheet.Padding.s
        buttonsView.addArrangedSubview(leftView)
        if let right = rightView {
            buttonsView.addArrangedSubview(right)
            leftView.autoMatch(.width, to: .width, of: right)
        }
        self.init(button: buttonsView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()

        self.addSubview(self.button)

        self.button.autoPinEdge(toSuperviewEdge: .top, withInset: self.topPadding)
        self.button.autoPinEdge(toSuperviewEdge: .left, withInset: self.sidePadding)
        self.button.autoPinEdge(toSuperviewEdge: .right, withInset: self.sidePadding)
        self.button.autoPinEdge(toSuperviewEdge: .bottom, withInset: self.topPadding)

//        self.backgroundColor = .white
    }

    private let button: UIView

    internal let topPadding: CGFloat = 14
    internal let sidePadding: CGFloat = 24
}
