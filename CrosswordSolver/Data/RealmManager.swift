//
//  RealmManager.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import RealmSwift
import SwiftyBeaver

/// Base class for interacting with realm
/// To add different objects, inherit from this with custom CRUD implementations
public class RealmManager {
    static let instance = RealmManager()

    // MARK: Setup

    internal init() {
        do {
            _ = try Realm()
        } catch let error {
            SwiftyBeaver.debug(error)
            SwiftyBeaver.error("Unable to initialize Realm.", error.localizedDescription)
            fatalError("Unable to initialize Realm instance.")
        }
    }

    /// Resets/clears the database
    func deleteAllFromDatabase() {
        guard let realm = try? Realm()
        else { return }

        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            SwiftyBeaver.error("Unable to delete all data from realm.", error.localizedDescription)
        }
    }

    // MARK: - Data loading

    /// Loads the word dictionary into realm if it has not been done before
    /// - Parameter onCompletion: Callback that runs once the load has completed
    internal func loadDictionaryIntoRealm(_ onCompletion: @escaping () -> Void = {}) throws {
        DispatchQueue(label: "realm-populate").async {
            // There are currenty 370,100 words in the dictionary which consumes a lot of memory
            // Release all the held data immediately after populating to free up memory
            autoreleasepool {
                guard let realm = try? Realm() else {
                    return
                }

                guard let path = Bundle.main.path(forResource: "words_dictionary", ofType: "json") else {
                    SwiftyBeaver.error("Unable to load words_dictionary.json")
                    return
                }

                // Check if there is already data to avoid loading the dictionary again
                if realm.objects(Word.self).count > 0 {
                    SwiftyBeaver.info("Word data is pre-populated.")
                    onCompletion()
                    return
                }

                guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .uncached) else {
                    SwiftyBeaver.error("Unable to read word dictionary file.")
                    return
                }

                let words = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Int]

                if words == nil {
                    SwiftyBeaver.error("Unable to serialise words from JSON")
                    return
                }

                try? realm.write {
                    realm.add(words!.map { Word(word: $0.key) })
                }

                SwiftyBeaver.info("Added: \(realm.objects(Word.self).count)")
                onCompletion()
            }
        }
    }
}
