//
//  Encodable+EXT.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import Foundation


extension Encodable {
    func asFormURLEncoded() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        
        // Decode JSON into dictionary to get key/value pairs with CodingKeys applied
        let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
        
        let components = dictionary.map { key, value -> String in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(value)"
            return "\(escapedKey)=\(escapedValue)"
        }
        
        let formString = components.joined(separator: "&")
        return Data(formString.utf8)
    }
}
