//
//  MangaDetail.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

struct MangaDetail {
    let id: String
    let coverId: String
    let title: String
    let description: String
    let coverUrl: String?
    let lastChapter: Int?
    
    init(id: String, coverId: String, title: String, description: String, coverUrl: String? = nil, lastChapter: Int) {
        self.id = id
        self.coverId = coverId
        self.title = title
        self.description = description
        self.coverUrl = coverUrl
        self.lastChapter = lastChapter
    }
    
    init(entity: MangaEntity) {
        self.id = entity.id
        self.coverId = entity.relationships.first(where: {$0.type == .coverArt})?.id ?? ""
        self.title = entity.attributes.title?.en ?? ""
        self.description = entity.attributes.description?.en ?? ""
        self.coverUrl = ""
        self.lastChapter = Int(entity.attributes.lastChapter ?? "0") ?? 0
    }
    static var mock: MangaDetail {
        MangaDetail(
            id: "mock-id-123",
            coverId: "mock-cover-456",
            title: "Mock Manga Title",
            description: "This is a mock description of a manga, useful for previews and testing.",
            coverUrl: Constants.randomImageUrl,
            lastChapter: 212
        )
    }
    static var mocks: [MangaDetail] {
        [
            MangaDetail(
                id: "mock-id-1",
                coverId: "cover-1",
                title: "Samurai Adventure",
                description: "A tale of honor and swordsmanship.",
                coverUrl: Constants.randomImageUrl,
                lastChapter: 100
            ),
            MangaDetail(
                id: "mock-id-2",
                coverId: "cover-2",
                title: "Cyberpunk Dreams",
                description: "A futuristic world filled with neon lights and secrets.",
                coverUrl: Constants.randomImageUrl,
                lastChapter: 400
            ),
            MangaDetail(
                id: "mock-id-3",
                coverId: "cover-3",
                title: "Romance in Spring",
                description: "A heartwarming romance set in a blooming town.",
                coverUrl: Constants.randomImageUrl,
                lastChapter: 100
            )
        ]
    }
}
