//
//  SearchController.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/07/29.
//

import RealmSwift
import SwiftyBeaver
import UIKit

/// Free text search screen returning any results that match the search text
final class SearchController: BaseViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.dataProvider.start()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.dataProvider.stop()
    }

    override func setupView() {
        super.setupView()

        self.title = "Search words"

        self.view.addSubview(self.searchBar)
        self.searchBar.autoPinEdge(toSuperviewMargin: .top)
        self.searchBar.autoPinEdges(toSuperviewEdges: [.left, .right])

        self.view.addSubview(self.tableView)

        self.tableView.autoPinEdge(.top, to: .bottom, of: self.searchBar)
        self.tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .top)
    }

    // MARK: - Data

    private lazy var dataProvider: BaseDataProvider<Word> = {
        let provider = BaseDataProvider<Word>(
            bindTo: .tableView(self.tableView),
            basePredicate: self.searchPredicate,
            filter: NSPredicate(value: true),
            sort: self.sortDescriptor)
        provider.updateDelegate = self
        return provider
    }()

    private var searchText: String = "" {
        didSet {
            guard self.searchText != oldValue else { return }
            self.searchTextDidUpdate()
        }
    }

    private var searchPredicate: NSPredicate {
        if self.searchText == "" {
            return .truePredicate
        } else {
            return NSPredicate(format: "word LIKE[c] %@", "\(self.searchText)*")
        }
    }

    private var sortDescriptor: [SortDescriptor] {
        return [SortDescriptor(keyPath: "word")]
    }

    private func searchTextDidUpdate() {
        self.dataProvider.filter = self.searchPredicate
    }

    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.autocapitalizationType = .none
        bar.autocorrectionType = .no
        bar.placeholder = "Search"
        bar.delegate = self
        bar.inputAccessoryView = self.toolbar
        return bar
    }()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [.init(
                            title: "?",
                            style: .plain,
                            target: self, action: #selector(onUnknownCharacter))]
        toolbar.sizeToFit()
        return toolbar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        return tableView
    }()

    @objc private func onUnknownCharacter() {

    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchBar.text ?? ""
    }
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.query().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let word = self.dataProvider.object(at: indexPath.row)
        else { return tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) }

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.attributedText = .init(string: word.word)
        return cell
    }
}

extension SearchController: DataProviderUpdateDelegate {
    func providerDataDidUpdate<F>(_ provider: BaseDataProvider<F>) where F: BaseObject {

    }
}

extension Array {
    func isIndexValid(_ index: Int) -> Bool {
        return index >= 0 && index < count
    }

    /** Safe index operator. Returns the item at the index if it doesn't exceed the array's range. */
    func item(at index: Int) -> Element? {
        guard isIndexValid(index) else { return nil }
        return self[index]
    }
}

extension NSPredicate {
    static var truePredicate: NSPredicate {
        return NSPredicate(value: true)
    }
}
