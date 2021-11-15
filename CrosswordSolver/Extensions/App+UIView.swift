//
//  App+UIView.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/11/15.
//

import UIKit

// MARK: - Drop shadow

extension UIView {
    public final func addDropShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        
        // Fix optimisation issues
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Border

extension UIView {
    func addBorder(color: UIColor = .black, width: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

// MARK: - Rounded corners

extension UIView {
    public final func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

// MARK: - Shake

extension UIView {
    public final func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

