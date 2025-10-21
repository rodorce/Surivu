//
//  Manga.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import Foundation

// MARK: - Datum
struct MangaEntity: Codable, Identifiable {
    let id: String
    let attributes: MangaAttributes
    let relationships: [Relationship]
    
    static var mock: MangaEntity {
        MangaEntity(
            id: "mock_manga_1",
            attributes: MangaAttributes(
                title: Title(en: "Title name has a very long long long long long long long long long long long long long long long long long long name"),
                description: MangaDescription(en: "Eng Desc", es: "Esp Desc", esLa: "Esp Latam Desc"),
                isLocked: true,
                lastVolume: "10",
                lastChapter: "7",
                publicationDemographic: "shounen",
                year: 1998,
                createdAt: Date.now,
                updatedAt: Date.now,
                version: 1,
                latestUploadedChapter: "chapter_id",
                tags: [
                    MangaTag(id: "tag_1", type: .tag, attributes: TagAttributes(name: Title(en: "Historical"), group: .genre, version: 1))
                ]
            ),
            relationships: [
                Relationship(
                id: "rel_id_1",
                type: RelationshipType.artist,
                related: ""),
                Relationship(
                id: "rel_id_2",
                type: RelationshipType.author,
                related: ""),
                Relationship(
                id: "rel_id_1",
                type: RelationshipType.coverArt,
                related: ""),
            ]
        )
    }
    
    static var mocks: [MangaEntity] {
        [
            MangaEntity(
                id: "mock_manga_1",
                attributes: MangaAttributes(
                    title: Title(en: "Title name has a very long long long long long long long long long long long long long long long long long long name"),
                    description: MangaDescription(en: "Eng Desc", es: "Esp Desc", esLa: "Esp Latam Desc"),
                    isLocked: true,
                    lastVolume: "10",
                    lastChapter: "7",
                    publicationDemographic: "shounen",
                    year: 1998,
                    createdAt: Date.now,
                    updatedAt: Date.now,
                    version: 1,
                    latestUploadedChapter: "chapter_id",
                    tags: [
                        MangaTag(id: "tag_1", type: .tag, attributes: TagAttributes(name: Title(en: "Historical"), group: .genre, version: 1))
                    ]
                ),
                relationships: [
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.artist,
                    related: ""),
                    Relationship(
                    id: "rel_id_2",
                    type: RelationshipType.author,
                    related: ""),
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.coverArt,
                    related: ""),
                ]
            ),
            MangaEntity(
                id: "mock_manga_2",
                attributes: MangaAttributes(
                    title: Title(en: "Another Title"),
                    description: MangaDescription(en: "Another Eng Desc", es: "Otra Esp Desc", esLa: "Otra Esp Latam Desc"),
                    isLocked: false,
                    lastVolume: "5",
                    lastChapter: "20",
                    publicationDemographic: "seinen",
                    year: 2015,
                    createdAt: Date.now,
                    updatedAt: Date.now,
                    version: 1,
                    latestUploadedChapter: "chapter_20",
                    tags: [
                        MangaTag(id: "tag_1", type: .tag, attributes: TagAttributes(name: Title(en: "Historical"), group: .genre, version: 1))
                    ]
                ),
                relationships: [
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.artist,
                    related: ""),
                    Relationship(
                    id: "rel_id_2",
                    type: RelationshipType.author,
                    related: ""),
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.coverArt,
                    related: ""),
                ]
            ),
            MangaEntity(
                id: "mock_manga_3",
                attributes: MangaAttributes(
                    title: Title(en: "Third Manga"),
                    description: MangaDescription(en: "Third Eng Desc", es: "Tercer Esp Desc", esLa: "Tercer Esp Latam Desc"),
                    isLocked: true,
                    lastVolume: "2",
                    lastChapter: "15",
                    publicationDemographic: "josei",
                    year: 2020,
                    createdAt: Date.now,
                    updatedAt: Date.now,
                    version: 1,
                    latestUploadedChapter: "chapter_15",
                    tags: [
                        MangaTag(id: "tag_1", type: .tag, attributes: TagAttributes(name: Title(en: "Historical"), group: .genre, version: 1))
                    ]
                ),
                relationships: [
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.artist,
                    related: ""),
                    Relationship(
                    id: "rel_id_2",
                    type: RelationshipType.author,
                    related: ""),
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.coverArt,
                    related: ""),
                ]
            ),
            MangaEntity(
                id: "mock_manga_4",
                attributes: MangaAttributes(
                    title: Title(en: "Fourth Story"),
                    description: MangaDescription(en: "Fourth Eng Desc", es: "Cuarta Esp Desc", esLa: "Cuarta Esp Latam Desc"),
                    isLocked: false,
                    lastVolume: "8",
                    lastChapter: "30",
                    publicationDemographic: "shoujo",
                    year: 2010,
                    createdAt: Date.now,
                    updatedAt: Date.now,
                    version: 1,
                    latestUploadedChapter: "chapter_30",
                    tags: [
                        MangaTag(id: "tag_1", type: .tag, attributes: TagAttributes(name: Title(en: "Historical"), group: .genre, version: 1))
                    ]
                ),
                relationships: [
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.artist,
                    related: ""),
                    Relationship(
                    id: "rel_id_2",
                    type: RelationshipType.author,
                    related: ""),
                    Relationship(
                    id: "rel_id_1",
                    type: RelationshipType.coverArt,
                    related: ""),
                ]
            )
        ]
    }

}

// MARK: - MangaAttributes
struct MangaAttributes: Codable {
    let title: Title?
    let description: MangaDescription?
    let isLocked: Bool?
    let lastVolume, lastChapter, publicationDemographic: String?
    let year: Int?
    let createdAt, updatedAt: Date?
    let version: Int?
    let latestUploadedChapter: String?
    let tags: [MangaTag]
}



enum ContentRating: String, Codable {
    case safe = "safe"
    case suggestive = "suggestive"
}

// MARK: - MangaDescription
struct MangaDescription: Codable {
    let en: String?
    let es, esLa: String?
    
    enum CodingKeys: String, CodingKey {
        case en, es
        case esLa = "es-la"
    }
}

enum OriginalLanguage: String, Codable {
    case ja = "ja"
    case ko = "ko"
    case zh = "zh"
}

enum Status: String, Codable {
    case completed = "completed"
    case ongoing = "ongoing"
}

// MARK: - Tag
struct MangaTag: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let type: TagType
    let attributes: TagAttributes
}

// MARK: - TagAttributes
struct TagAttributes: Codable, Equatable, Hashable {
    let name: Title
    let group: Group
    let version: Int
}

// MARK: - FluffyDescription
struct FluffyDescription: Codable {
}

enum Group: String, CaseIterable, Codable, Equatable {
    case content = "content"
    case format = "format"
    case genre = "genre"
    case theme = "theme"
}

// MARK: - Title
struct Title: Codable, Equatable, Hashable {
    let en: String?
}

enum TagType: String, Codable, CaseIterable {
    case tag = "tag"
}

// MARK: - Relationship
struct Relationship: Codable {
    let id: String
    let type: RelationshipType
    let related: String?
}

enum RelationshipType: String, Codable {
    case artist = "artist"
    case author = "author"
    case coverArt = "cover_art"
    case creator = "creator"
    case manga = "manga"
    case tag
}

