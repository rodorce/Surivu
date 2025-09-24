//
//  MangaDetail.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

enum MangaGenre: String, CaseIterable {
    case romance = "Romance"
    case action = "Action"
    case martialArts = "Martial Arts"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case comedy = "Comedy"
    case unknown = "Unknown"
    
    var id: String {
        switch self {
        case .romance:
            return "423e2eae-a7a2-4a8b-ac03-a8351462d71d"
        case .action:
            return "391b0423-d847-456f-aff0-8b0cfc03066b"
        case .martialArts:
            return "799c202e-7daa-44eb-9cf7-8a3c0441531e"
        case .drama:
            return "b9af3a63-f058-46de-a9a0-e0c13906197a"
        case .fantasy:
            return "cdc58593-87dd-415e-bbc0-2ec27bf404cc"
        case .comedy:
            return "4d32cc48-9f00-4cca-9b5a-a839f0764984"
        case .unknown:
            return "unknown_id"
        }
    }
}

struct MangaDetail {
    let id: String
    let coverId: String
    let title: String
    let description: String
    let coverUrl: String?
    let lastChapter: Int?
    let genres: [MangaGenre]
    
    init(id: String, coverId: String, title: String, description: String, coverUrl: String? = nil, lastChapter: Int, genres: [MangaGenre]) {
        self.id = id
        self.coverId = coverId
        self.title = title
        self.description = description
        self.coverUrl = coverUrl
        self.lastChapter = lastChapter
        self.genres = genres
    }
    
    init(entity: MangaEntity) {
        self.id = entity.id
        self.coverId = entity.relationships.first(where: {$0.type == .coverArt})?.id ?? ""
        self.title = entity.attributes.title?.en ?? ""
        self.description = entity.attributes.description?.en ?? ""
        self.coverUrl = ""
        self.lastChapter = Int(entity.attributes.lastChapter ?? "0") ?? 0
        self.genres = entity.attributes.tags.map { MangaGenre(rawValue: $0.attributes.name.en ?? "")! }
    }
    static var mock: MangaDetail {
        MangaDetail(
            id: "mock-id-123",
            coverId: "mock-cover-456",
            title: "Mock Manga Title",
            description: "This is a mock description of a manga, useful for previews and testing.",
            coverUrl: Constants.randomImageUrl,
            lastChapter: 212,
            genres: []
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
                lastChapter: 100,
                genres: []
            ),
            MangaDetail(
                id: "mock-id-2",
                coverId: "cover-2",
                title: "Cyberpunk Dreams",
                description: "A futuristic world filled with neon lights and secrets.",
                coverUrl: Constants.randomImageUrl,
                lastChapter: 400,
                genres: []
            ),
            MangaDetail(
                id: "mock-id-3",
                coverId: "cover-3",
                title: "Romance in Spring",
                description: "A heartwarming romance set in a blooming town.",
                coverUrl: Constants.randomImageUrl,
                lastChapter: 100,
                genres: []
            )
        ]
    }
}
