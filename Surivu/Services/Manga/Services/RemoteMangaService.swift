//
//  RemoteMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import Foundation

struct RemoteMangaService: MangaService {
    func getMangas() async throws -> [Manga] {
        return Manga.mocks
    }
    
    func getManga(id: Int) async throws -> Manga {
        guard let manga = Manga.mocks.first(where: {$0.id == id}) else {
            throw URLError(.cannotLoadFromNetwork)
        }
        return manga
    }
}
