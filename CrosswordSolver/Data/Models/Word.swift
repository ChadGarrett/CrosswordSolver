//
//  Word.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import RealmSwift

public final class Word: BaseObject {
    @Persisted var word: String

    convenience init(word: String) {
        self.init()
        self.word = word
    }
}
