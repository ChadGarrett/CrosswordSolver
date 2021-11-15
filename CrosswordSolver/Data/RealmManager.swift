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
    
    internal var database: Realm
    
    // MARK: Setup
    
    internal init() {
        do {
            database = try Realm()
        } catch let error {
            SwiftyBeaver.debug(error)
            SwiftyBeaver.error("Unable to initialize Realm.", error.localizedDescription)
            fatalError("Unable to initialize Realm instance.")
        }
    }
    
    /// Resets/clears the database
    func deleteAllFromDatabase() {
        do {
            try self.database.write {
                database.deleteAll()
            }
        } catch let error {
            SwiftyBeaver.error("Unable to delete all data from realm.", error.localizedDescription)
        }
    }
    
    // MARK: -Data loading
    
    /// Loads the word dictionary into realm if it has not been done before
    /// - Parameter onCompletion: Callback that runs once the load has completed
    internal func loadDictionaryIntoRealm(_ onCompletion: () -> Void = {}) throws {        
        guard let path = Bundle.main.path(forResource: "words_dictionary", ofType: "json") else {
            SwiftyBeaver.error("Unable to load words_dictionary.json")
            return
        }
        
        // Check if there is already data to avoid loading the dictionary again
        if self.database.objects(Word.self).count > 0 {
            onCompletion()
            return
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .uncached)
        let words = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Int>
        
        if words == nil {
            SwiftyBeaver.error("Unable to serialise words from JSON")
            return
        }

        try self.database.write {
            words?.enumerated().forEach { (index, word) in
                self.database.add(Word(word: word.key))
            }
        }
        
        SwiftyBeaver.info("Added: \(self.database.objects(Word.self).count)")
        onCompletion()
    }
}
