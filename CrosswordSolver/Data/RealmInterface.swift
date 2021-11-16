//
//  RealmInterface.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import RealmSwift
import SwiftyBeaver

/// Generic interface for performing CRUD objects within Realm
final class RealmInterface<T: BaseObject>: RealmManager {

    // MARK: Sync

    internal func sync(_ objects: [T]) {
        guard let realm = try? Realm()
        else { return }

        do {
            try realm.write {
                realm.add(objects, update: .all)
            }
        } catch let error {
            SwiftyBeaver.error("Unable to sync objects.", error.localizedDescription)
        }
    }

    // MARK: Add

    @discardableResult internal func add(object: T) -> Bool {
        guard let realm = try? Realm()
        else { return false }

        do {
            SwiftyBeaver.info("Adding object locally.")
            try realm.write {
                realm.add(object, update: .all)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to add object locally.", error.localizedDescription)
            return false
        }
    }

    // MARK: Update

    @discardableResult internal func update(object: T) -> Bool {
        guard let realm = try? Realm()
        else { return false }

        do {
            SwiftyBeaver.info("Updating object locally.")
            try realm.write {
                realm.add(object, update: .modified)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to update object locally.", error.localizedDescription)
            return false
        }
    }

    // MARK: Delete

    @discardableResult internal func delete(object: T) -> Bool {
        guard let realm = try? Realm()
        else { return false }

        do {
            SwiftyBeaver.info("Deleting object locally.")
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            SwiftyBeaver.error("Unable to delete object locally.", error.localizedDescription)
            return false
        }
    }
}
