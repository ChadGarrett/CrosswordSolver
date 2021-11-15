//
//  App+UIStackView.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/08.
//

import UIKit

extension UIStackView {
    
    /// Removes the view completely from the UIStackView
    /// Remove the view as an arranged subview and a subview
    /// - Parameter view: The view to be completely removed from the UIStackView
    func removeFully(_ view: UIView) {
        self.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    /// Fully removes all views from the UIStackView
    func removeAllFully() {
        self.arrangedSubviews.forEach { view in
            self.removeFully(view)
        }
    }
}
