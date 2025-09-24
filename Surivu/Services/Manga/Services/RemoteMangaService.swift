//
//  RemoteMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation
import SwiftUI


struct RemoteMangaService: MangaService {
    let networkService: NetworkService
    
    //MARK: - Manga Details
    func getMangas(endpoint: String) async throws -> [MangaDetail] {
        let mangaEntities: [MangaEntity] = try await generateMangaEntities(endpoint: endpoint)
        let mangaDetails: [MangaDetail] = try await generateMangaDetails(mangaEntities: mangaEntities)
        return mangaDetails
    }
    
    func getManga(mangas: [MangaDetail], id: String) -> MangaDetail? {
        return mangas.first(where: {$0.id == id})
    }
    
    func getCover(coverArtId: String) async throws -> CoverEntity {
        let data = try await networkService.makeNetworkRequest(endpoint: "\(Endpoints.cover)/\(coverArtId)")
        return try decode(APIObjectResponse<CoverEntity>.self, from: data).data
    }
    
    private func generateMangaEntities(endpoint: String) async throws -> [MangaEntity] {
        let data = try await networkService.makeNetworkRequest(endpoint: endpoint)
        return try decode(APIListResponse<MangaEntity>.self, from: data).data
    }
    
    private func generateMangaDetails(mangaEntities: [MangaEntity]) async throws -> [MangaDetail] {
        return try await withThrowingTaskGroup(of: MangaDetail.self) { group in
            for mangaEntity in mangaEntities {
                group.addTask {
                    let coverEntity: CoverEntity = try await getCover(coverArtId: mangaEntity.relationships.first(where: {$0.type == .coverArt})?.id ?? "")
                    return await MangaDetail(
                        id: mangaEntity.id,
                        coverId: coverEntity.id,
                        title: mangaEntity.attributes.title?.en ?? "",
                        description: mangaEntity.attributes.description?.en ?? "",
                        coverUrl: "\(Endpoints.coversImageUrl)/\(mangaEntity.id)/\(coverEntity.attributes.fileName)",
                        lastChapter: Int(mangaEntity.attributes.lastChapter ?? "0") ?? 0,
                        genres: mangaEntity.attributes.tags.map { MangaGenre(rawValue: $0.attributes.name.en ?? "") ?? .unknown }
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
    
    //MARK: - Chapters
    func getChapters(endpoint: String) async throws -> [ChapterDetail] {
        guard let chapterEntities: [ChapterEntity] = try await generateChapterEntities(endpoint: endpoint) else {
            return []
        }
        return chapterEntities.map { entity in
            ChapterDetail(chapterEntity: entity)
        }
    }
    
    func getChapterImages(endpoint: String) async throws -> [String] {
        let chapterMetadataEntity = try await getChapterMetadataEntity(endpoint: endpoint)
        let chapterImages: [String] = chapterMetadataEntity.chapter.dataSaver.map { imageId in
            return "\(chapterMetadataEntity.baseURL)/data-saver/\(chapterMetadataEntity.chapter.hash)/\(imageId)"
        }
        return chapterImages
    }
    
    private func getChapterMetadataEntity(endpoint: String) async throws -> ChapterMetadataEntity {
        let data = try await networkService.makeNetworkRequest(endpoint: endpoint)
        return try decode(ChapterMetadataEntity.self, from: data)
    }
    
    private func generateChapterEntities(endpoint: String) async throws -> [ChapterEntity]? {
        let data = try await networkService.makeNetworkRequest(endpoint: endpoint)
        return try decode(APIListResponse<ChapterEntity>.self, from: data).data
    }
    
}
