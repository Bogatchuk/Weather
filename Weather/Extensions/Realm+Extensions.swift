//
//  Realm+Extension.swift
//  Weather
//
//  Created by Roma Bogatchuk on 24.01.2023.
//

import RealmSwift

extension Realm {
    
    func deleteAll<T: Object>(_ type: T.Type) {
        delete(objects(T.self))
    }
}
