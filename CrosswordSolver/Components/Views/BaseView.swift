//
//  BaseView.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupView() {
        // Subclasses to override
    }
}
