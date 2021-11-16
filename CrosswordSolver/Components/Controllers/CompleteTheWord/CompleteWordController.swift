//
//  CompleteWordController.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/30.
//

import Material
import SwiftyBeaver

final class CompleteWordController: BaseViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.rightBarButtonItem = self.btnClear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()
        self.title = "Complete Word"

        self.view.addSubview(self.stackView)
        self.stackView.autoPinEdge(toSuperviewMargin: .top, withInset: Stylesheet.Padding.m)
        self.stackView.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.view.addSubview(self.adjustTextFieldButtonView)
        self.adjustTextFieldButtonView.autoPinEdge(.top, to: .bottom, of: self.stackView)
        self.adjustTextFieldButtonView.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.view.addSubview(self.lblNumLetters)
        self.lblNumLetters.autoPinEdge(.top, to: .bottom, of: self.adjustTextFieldButtonView)
        self.lblNumLetters.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.view.addSubview(self.btnSearch)
        self.btnSearch.autoPinEdge(.top, to: .bottom, of: self.lblNumLetters, withOffset: 14)
        self.btnSearch.autoPinEdges(toSuperviewEdges: [.left, .right], withInset: Stylesheet.Padding.s)

        self.view.addSubview(self.tableView)
        self.tableView.autoPinEdge(.top, to: .bottom, of: self.btnSearch, withOffset: Stylesheet.Padding.s)
        self.tableView.autoPinEdges(toSuperviewEdges: [.left, .right, .bottom])

        self.prepopulateTextFields()
        self.txtLettersDidUpdate()
    }

    /// Adds the initial 3 textfields to the view
    private func prepopulateTextFields() {
        for n in 1...self.minCharacters {
            let textField = self.getLettertextField(index: n)
            self.textFields.append(textField)
            self.stackView.addArrangedSubview(textField)

            // Set the first field as the active
            if n == 1 {
                _ = textField.becomeFirstResponder()
            }
        }
    }

    // MARK: - Properties

    private var minCharacters: Int = 3
    private var maxCharacters: Int = 12

    private var textFields: [TextField] = []

    // MARK: - Data

    /// Current result set based on search criteria
    private var displayData: [Word] = [] {
        didSet { self.displayDataDidUpdate() }
    }

    /// Data source to query the database of words
    private var dataProvider = BaseDataProvider<Word>(
        bindTo: .none,
        basePredicate: .truePredicate,
        filter: .truePredicate,
        sort: [.init(keyPath: "word")])

    // MARK: - Subviews

    private lazy var btnClear = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(onClear))

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Stylesheet.Padding.xs
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var btnSearch: RaisedButton = {
        let button = RaisedButton(title: "Search")
        button.addTarget(self, action: #selector(onSearch), for: .touchUpInside)
        button.backgroundColor = Color.blue.accent4
        button.titleColor = .white
        return button
    }()

    private lazy var btnRemoveLetter: IconButton = {
        let button = IconButton(image: Icon.clear)
        button.setImage(nil, for: .disabled)
        button.addTarget(self, action: #selector(onRemoveLetter), for: .touchUpInside)
        return button
    }()

    private lazy var btnAddLetter: IconButton = {
        let button = IconButton(image: Icon.add)
        button.setImage(nil, for: .disabled)
        button.addTarget(self, action: #selector(onAddLetter), for: .touchUpInside)
        return button
    }()

    private lazy var adjustTextFieldButtonView = HorizontalButtonView(leftView: self.btnRemoveLetter, rightView: self.btnAddLetter)

    private lazy var lblNumLetters = UILabel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    // MARK: - Helpers

    private final func getLettertextField(index: Int) -> TextField {
        let textField = TextField()
        textField.backgroundColor = Color.grey.lighten1
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.delegate = self
        textField.tag = index
        textField.placeholder = "?"
        textField.placeholderAnimation = .hidden
        textField.inputAccessoryView = self.toolbar
        return textField
    }

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [
            .init(title: "<", style: .plain, target: self, action: #selector(onLeft)),
            .flexibleSpace(),
            .init(title: "<", style: .plain, target: self, action: #selector(onRight))
        ]
        return toolbar
    }()

    @objc private func onLeft() {
        // TODO
    }

    @objc private func onRight() {
        // TODO
    }

    private final func txtLettersDidUpdate() {
        // Clear the current search
        self.displayData = []

        self.lblNumLetters.attributedText = .init(
            string: "\(self.textFields.count) letters",
            attributes: Stylesheet.Text.body_center)

        self.btnRemoveLetter.isEnabled = (self.textFields.count > 3)
        self.btnAddLetter.isEnabled = (self.textFields.count < self.maxCharacters)

        SwiftyBeaver.verbose("Number of textfields: \(self.textFields.count)")
        SwiftyBeaver.verbose("Number of arranged subviews: \(self.stackView.arrangedSubviews.count)")
        SwiftyBeaver.verbose("Number of subviews: \(self.stackView.subviews.count)")
    }

    private func displayDataDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Action

extension CompleteWordController {
    @objc private func onRemoveLetter() {
        self.textFields.forEach { item in item.resignFirstResponder() }

        guard self.textFields.count > self.minCharacters else { return }

        let removedTextField = self.textFields.removeLast()
        removedTextField.removeFromSuperview()
        self.stackView.removeArrangedSubview(removedTextField)

        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }

        self.txtLettersDidUpdate()
    }

    @objc private func onAddLetter() {
        guard self.textFields.count < self.maxCharacters else { return }

        let newCharacterField = self.getLettertextField(index: self.textFields.count)
        self.textFields.append(newCharacterField)
        self.stackView.addArrangedSubview(newCharacterField)

        UIView.animate(withDuration: 0.8) {
            self.stackView.layoutIfNeeded()
        }

        self.txtLettersDidUpdate()
    }

    @objc private func onClear() {
        self.textFields.forEach { textField in
            textField.text = nil
        }

        self.displayData = []
    }

    @objc private func onSearch() {
        let predicate = NSPredicate(format: "word LIKE[c] %@", "\(self.getSearchText())")
        self.dataProvider.filter = predicate

        self.displayData = self.dataProvider
            .query()
            .filter { $0.word.count == self.textFields.count }
    }

    private func getSearchText() -> String {
        var result: String = ""
        self.stackView.subviews.forEach { view in
            if let character = (view as? TextField)?.text {
                // Turn ? into the wildcard characters
                if character == "?" || character == "" {
                    result += "*"
                } else {
                    result += character
                }

            } else {
                result += "*"
            }
        }
        return result
    }
}

extension CompleteWordController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let word = self.displayData.item(at: indexPath.row)
        else { return tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) }

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.attributedText = .init(string: word.word)
        return cell
    }
}

extension CompleteWordController: TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        guard let text = text else { return }

        if text.count >= 1 {
            textField.resignFirstResponder()

            if let index = self.textFields.firstIndex(of: textField),
               let nextTextfield = self.textFields.item(at: index+1) {
                _ = nextTextfield.becomeFirstResponder()
            }
        }
    }
}
