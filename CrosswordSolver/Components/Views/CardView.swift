//
//  CardView.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import Material
import UIKit

final class CardView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = Color.grey.lighten3.cgColor
        self.layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addDropShadow()
    }
}
