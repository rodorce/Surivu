//
//  ChapterMetadata.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//

// MARK: - ChapterMetadataEntity
struct ChapterMetadataEntity: Codable {
    let result: String
    let baseURL: String
    let chapter: ChapterMetadata

    enum CodingKeys: String, CodingKey {
        case result
        case baseURL = "baseUrl"
        case chapter
    }
}

// MARK: - Chapter
struct ChapterMetadata: Codable {
    let hash: String
    let data, dataSaver: [String]
}
