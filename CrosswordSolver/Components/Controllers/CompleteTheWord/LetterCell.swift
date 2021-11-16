//
//  LetterCell.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import Material
import UIKit

protocol LetterCellDelegate: AnyObject {
    func textDidUpdate(to letter: String)
}

final class LetterCell: UICollectionViewCell {

    internal weak var delegate: LetterCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.contentView.addSubview(self.textField)
        self.textField.autoPinEdgesToSuperviewEdges()
    }

    // MARK: - Subviews

    private lazy var textField: TextField = {
        let textField = TextField()
        textField.backgroundColor = Color.grey.lighten1
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.delegate = self
        return textField
    }()
}

extension LetterCell: TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        guard let text = text else { return }
        self.delegate?.textDidUpdate(to: text)
    }
}
