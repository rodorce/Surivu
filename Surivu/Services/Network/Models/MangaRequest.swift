//
//  APIRequest.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 23/09/25.
//

struct MangaRequest {
    let title: String?
    var limit: String = "10"
    var genres: [MangaGenre]?
    
    init(title: String?, limit: String, genres: [MangaGenre]?) {
        self.title = title
        self.limit = limit
        self.genres = genres
    }
}
