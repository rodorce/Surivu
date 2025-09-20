//
//  LocalPersistanceManager.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

struct LocalPersistenceManager {
    let service: LocalPersistenceService
    
    init(service: LocalPersistenceService) {
        self.service = service
    }
    
    func save<T: Codable>(_ object: T, forKey key: String) -> Bool {
        service.save(object, forKey: key)
    }
    func save(_ value: String, forKey key: String) -> Bool {
        service.save(value, forKey: key)
    }

    func get(forKey key: String) -> String? {
        service.get(forKey: key)
    }
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        service.get(type, forKey: key)
    }
}
