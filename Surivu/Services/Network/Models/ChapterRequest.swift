//
//  ChapterRequest.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 24/09/25.
//

//byMangaId: mangaId, limit: limit, offset: offset

struct ChapterRequest {
    let mangaId: String
    let limit: String
    let offset: String
    
    init(mangaId: String, limit: String?, offset: String?) {
        self.mangaId = mangaId
        self.limit = limit ?? "100"
        self.offset = offset ?? "0"
    }
}
