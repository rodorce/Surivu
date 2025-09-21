//
//  Chapters.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import Foundation

// MARK: - ChapterEntity
struct ChapterEntity: Codable {
    let id, type: String
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let volume, chapter, title, translatedLanguage: String?
    let isUnavailable: Bool?
    let publishAt, readableAt, createdAt, updatedAt: Date?
    let pages, version: Int?

    enum CodingKeys: String, CodingKey {
        case volume, chapter, title, translatedLanguage
        case isUnavailable, publishAt, readableAt, createdAt, updatedAt, pages, version
    }
}
