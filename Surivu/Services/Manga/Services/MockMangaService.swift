//
//  MockMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

struct MockMangaService: MangaService {
    func getMangas() async throws -> [Manga] {
        return Manga.mocks
    }
    
    func getManga(id: Int) async throws -> Manga {
        return Manga.mock
    }
}
