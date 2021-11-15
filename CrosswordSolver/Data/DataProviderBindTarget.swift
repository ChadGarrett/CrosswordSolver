//
//  DataProviderBindTarget.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import UIKit

enum DataProviderBindTarget {
    case none
    case tableView(UITableView)
    case collectionView(UICollectionView)
}

extension DataProviderBindTarget {
    func handleInitialUpdate() {
        switch self {
        case .none:
            break

        case .tableView(let tableView):
            self.handleInitialUpdate(tableView)

        case .collectionView(let collectionView):
            self.handleInitialUpdate(collectionView)
        }
    }

    func handleUpdates(deletes: [Int], inserts: [Int], changes: [Int], limit: Int?) {
        switch self {
        case .none:
            break

        case .tableView(let tableView):
            self.handleUpdates(
                tableView, deletes: deletes, inserts: inserts, changes: changes, limit: limit, section: 0) // TODO: Section

        case .collectionView(let collectionView):
            self.handleUpdates(
                collectionView, deletes: deletes, inserts: inserts, changes: changes, limit: limit, section: 0) // TODO: Section
        }
    }
}

// TableView
extension DataProviderBindTarget {
    private func handleInitialUpdate(_ tableView: UITableView) {
        tableView.reloadData()
    }

    private func handleUpdates(_ tableView: UITableView, deletes: [Int], inserts: [Int], changes: [Int], limit: Int?, section: Int) {
        tableView.beginUpdates()

        tableView.insertRows(
            at: inserts.map({ IndexPath(row: $0, section: section) }),
            with: .automatic)

        tableView.deleteRows(
            at: deletes.map({ IndexPath(row: $0, section: section) }),
            with: .automatic)

        tableView.reloadRows(
            at: changes.map({ IndexPath(row: $0, section: section) }),
            with: .automatic)

        tableView.endUpdates()
    }
}

// CollectionView
extension DataProviderBindTarget {
    private func handleInitialUpdate(_ collectionView: UICollectionView) {
        collectionView.reloadData()
    }

    private func handleUpdates(_ collectionView: UICollectionView, deletes: [Int], inserts: [Int], changes: [Int], limit: Int?, section: Int) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: inserts.map({ IndexPath(row: $0, section: section) }))
            collectionView.deleteItems(at: deletes.map({ IndexPath(row: $0, section: section) }))
            collectionView.reloadItems(at: changes.map({ IndexPath(row: $0, section: section) }))
        }, completion: nil)
    }
}
