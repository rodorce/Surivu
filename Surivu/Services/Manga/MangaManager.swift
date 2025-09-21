//
//  MangaManager.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI

@MainActor
@Observable
class MangaManager {
    private let service: MangaService
    private(set) var mangas: [MangaDetail] = []
    
    init(service: MangaService) {
        self.service = service
    }
    
    func getMangasBy(title: String?, limit: Int?) async throws {
        let title = title ?? ""
        let limit = limit ?? 30
        mangas = try await service.getMangasBy(title: title, limit: String(limit))
    }
    
    func getManga(id: String) async throws -> MangaDetail {
        try await service.getManga(mangas: mangas, id: id)
    }
    
    func getChapters(mangaId: String, limit: Int?, offset: Int) async throws -> [ChapterDetail] {
        let limit = limit ?? 100 //100 is the max limit set by the api.
        return try await service.getChapters(byMangaId: mangaId, limit: limit, offset: offset)
    }
    func getChapterImages(chapterId: String) async throws -> [String] {
        try await service.getChapterImages(chapterId: chapterId)
    }
}
