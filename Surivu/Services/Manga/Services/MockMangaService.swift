//
//  MockMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

struct MockMangaService: MangaService {
    func getMangasBy(title: String, limit: String) async throws -> [MangaDetail] {
        return MangaDetail.mocks
    }
    
    func getManga(mangas: [MangaDetail]?, id: String) async throws -> MangaDetail {
        return MangaDetail.mock
    }
    
    
}
