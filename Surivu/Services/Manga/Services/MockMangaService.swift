//
//  MockMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation

struct MockMangaService: MangaService {
    func getMangas(title: String?, limit: String?, genres: [MangaGenre]?) async throws -> [MangaEntity] {
        MangaEntity.mocks
    }
    
    func getChapters(mangaId: String, limit: Int?, offset: Int) async throws -> [ChapterEntity] {
        []
    }
    
    func getChapterImages(chapterId: String) async throws -> [String] {
        [Constants.randomImageUrl]
    }
    
    func getCover(coverArtId: String) async throws -> CoverEntity {
        CoverEntity(id: "", type: "", attributes: CoverAttributes(description: "", fileName: "", locale: "", volume: "", createdAt: .now, updatedAt: .now, version: 1))
    }
    
    
}
