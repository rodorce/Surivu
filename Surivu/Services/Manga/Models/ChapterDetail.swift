//
//  ChapterDetail.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//

import Foundation

struct ChapterDetail: Hashable {
    let id: String
    let chapter: String
    let title: String
    let translatedLanguage: String
    let pages: Int
    let createdAt: Date
    let updatedAt: Date
    
    init(id: String, chapter: String, title: String, translatedLanguage: String, pages: Int, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.chapter = chapter
        self.title = title
        self.translatedLanguage = translatedLanguage
        self.pages = pages
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(chapterEntity: ChapterEntity) {
        self.id = chapterEntity.id
        self.chapter = String(format: "%.2f", Double(chapterEntity.attributes.chapter ?? "0") ?? 0)
        self.title = chapterEntity.attributes.title ?? ""
        self.translatedLanguage = chapterEntity.attributes.translatedLanguage ?? ""
        self.pages = chapterEntity.attributes.pages ?? 0
        self.createdAt = chapterEntity.attributes.createdAt ?? Date.now
        self.updatedAt = chapterEntity.attributes.updatedAt ?? Date.now
    }
    
    static let mock = ChapterDetail(
        id: "123",
        chapter: "1.00",
        title: "The Beginning",
        translatedLanguage: "en",
        pages: 32,
        createdAt: Date(timeIntervalSince1970: 1_700_000_000), // fixed date for consistency
        updatedAt: Date(timeIntervalSince1970: 1_700_100_000)
    )
    
    static let mocks: [ChapterDetail] = [
        ChapterDetail(
            id: "123",
            chapter: "1.00",
            title: "The Beginning",
            translatedLanguage: "en",
            pages: 32,
            createdAt: Date(timeIntervalSince1970: 1_700_000_000),
            updatedAt: Date(timeIntervalSince1970: 1_700_100_000)
        ),
        ChapterDetail(
            id: "124",
            chapter: "1.50",
            title: "A Strange Encounter",
            translatedLanguage: "en",
            pages: 28,
            createdAt: Date(timeIntervalSince1970: 1_700_200_000),
            updatedAt: Date(timeIntervalSince1970: 1_700_300_000)
        ),
        ChapterDetail(
            id: "125",
            chapter: "2.00",
            title: "The Journey Continues",
            translatedLanguage: "en",
            pages: 35,
            createdAt: Date(timeIntervalSince1970: 1_700_400_000),
            updatedAt: Date(timeIntervalSince1970: 1_700_500_000)
        )
    ]
}
