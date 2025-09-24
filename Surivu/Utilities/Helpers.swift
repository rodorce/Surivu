//
//  Helpers.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 24/09/25.
//
import Foundation

func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(T.self, from: data)
}
