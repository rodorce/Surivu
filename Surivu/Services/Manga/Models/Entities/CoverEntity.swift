//
//  CoverEntity.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

import Foundation

// MARK: - Welcome
struct CoverEntity: Codable {
    let id, type: String
    let attributes: CoverAttributes
}

// MARK: - Attributes
struct CoverAttributes: Codable {
    let description, fileName, locale: String
    let volume: String?
    let createdAt, updatedAt: Date
    let version: Int
}
