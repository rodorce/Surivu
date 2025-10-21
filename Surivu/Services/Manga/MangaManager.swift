//
//  MangaManager.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI
import Combine

actor MangaManager: ObservableObject {
    private let service: MangaService
    @Published private(set) var mangas: [MangaDetail] = []
    
    init(service: MangaService) {
        self.service = service
    }
    
    //MARK: - Mangas
    func getMangasBy(title: String?, limit: String?, tags: [MangaTag]?) async throws {
        let mangaEntities: [MangaEntity] = try await service.getMangas(title: title, limit: limit, tags: tags)
        mangas = try await generateMangaDetails(mangaEntities: mangaEntities)
    }
    
    func getManga(id: String) -> MangaDetail? {
        return mangas.first(where: {$0.id == id})
    }
    
    func getMangaTags() async throws -> [MangaTag] {
        return try await service.getMangaTags()
    }
    
    //MARK: - Chapters
    func getChapters(mangaId: String, limit: Int?, offset: Int) async throws -> [ChapterDetail] {
        let chapterEntities: [ChapterEntity] = try await service.getChapters(mangaId: mangaId, limit: limit, offset: offset)
        
        // Sequentially await each `ChapterDetail` creation
        var details: [ChapterDetail] = []
        for entity in chapterEntities {
            let detail = await ChapterDetail(chapterEntity: entity)
            details.append(detail)
        }
        
        return details
    }
    
    func getChapterImages(chapterId: String) async throws -> [String] {
        return try await service.getChapterImages(chapterId: chapterId)
    }
    
    //MARK: - Helper Functions - Mangas
    private func generateMangaDetails(mangaEntities: [MangaEntity]) async throws -> [MangaDetail] {
        return try await withThrowingTaskGroup(of: MangaDetail.self) { group in
            for mangaEntity in mangaEntities {
                group.addTask {
                    let coverArtId = mangaEntity.relationships.first(where: {$0.type == .coverArt})?.id ?? ""
                    let coverEntity: CoverEntity = try await self.service.getCover(coverArtId: coverArtId)
                    let coverUrl = try await URLRequest(
                        endpoint: CoversImageEndpoint.getImage(mangaId: mangaEntity.id, imageId: coverEntity.attributes.fileName)
                    ).url?.absoluteString
                    return await MangaDetail(
                        id: mangaEntity.id,
                        coverId: coverEntity.id,
                        title: mangaEntity.attributes.title?.en ?? "",
                        description: mangaEntity.attributes.description?.en ?? "",
                        coverUrl: coverUrl,
                        lastChapter: Int(mangaEntity.attributes.lastChapter ?? "0") ?? 0,
                        genres: mangaEntity.attributes.tags
                    )
                }
            }
            
            var details: [MangaDetail] = []
            for try await detail in group {
                details.append(detail)
            }
            return details
        }
    }
}
