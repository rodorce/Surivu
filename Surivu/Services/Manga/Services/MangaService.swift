//
//  MangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

protocol MangaService {
    func getMangasBy(title: String, limit: String) async throws -> [MangaDetail]
    func getManga(mangas: [MangaDetail]?, id: String) async throws -> MangaDetail
}
