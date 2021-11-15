//
//  App+PureLayout.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import PureLayout

extension UIView {
    /// Pins all passed edges to their superviews edge
    func autoPinEdges(toSuperviewEdges edges: [ALEdge], withInset inset: CGFloat = 0) {
        edges.forEach { edge in
            self.autoPinEdge(toSuperviewEdge: edge, withInset: inset)
        }
    }

    func addSubviewAndPinEdgesToSuperview(_ view: UIView, with insets: UIEdgeInsets) {
        self.addSubview(view)
        view.autoPinEdgesToSuperviewEdges(with: insets)
    }
}
