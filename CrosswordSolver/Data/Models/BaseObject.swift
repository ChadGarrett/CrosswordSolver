//
//  BaseObject.swift
//  CrosswordSolver
//
//  Created by Chad Garrett on 2021/08/06.
//

import RealmSwift

public class BaseObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
}
