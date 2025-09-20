//
//  LocalPersistenceService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//


protocol LocalPersistenceService {
    func save<T: Codable>(_ object: T, forKey key: String) -> Bool
    func save(_ value: String, forKey key: String) -> Bool
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T?
    func get(forKey key: String) -> String?
    func delete(forKey key: String)
}
