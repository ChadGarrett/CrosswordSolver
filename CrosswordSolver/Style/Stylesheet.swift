//
//  Stylesheet.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import UIKit

public struct Stylesheet {
    public struct Padding {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 12
        static let l: CGFloat = 8
    }

    public struct Button {
        static let s: Int = 12
        static let m: Int = 16
        static let l: Int = 20
    }

    public struct Text {
        //
        // Title
        //
        static let title: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title1),
            .foregroundColor: UIColor.label
        ]

        //
        // HEADING 1
        //
        static let heading_1: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: UIColor.label
        ]

        static let heading_1_center: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .paragraphStyle: Stylesheet.center,
            .foregroundColor: UIColor.label
        ]

        //
        // HEADING 2
        //

        static let subheading: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline),
            .foregroundColor: UIColor.label
        ]

        static let heading_2_center: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline),
            .paragraphStyle: Stylesheet.center,
            .foregroundColor: UIColor.label
        ]

        // Callout
        static let callout: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .foregroundColor: UIColor.label
        ]

        //
        // Body
        //
        static let body: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.label
        ]

        static let body_center: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .paragraphStyle: Stylesheet.center,
            .foregroundColor: UIColor.label
        ]

        //
        // Loader text
        //
        static let loader: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .paragraphStyle: Stylesheet.center,
            .foregroundColor: UIColor.white
        ]
    }

    // MARK: - Paragraph styles

    static let left: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        return paragraph
    }()

    static let center: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        return paragraph
    }()

    static let right: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
        return paragraph
    }()
}
