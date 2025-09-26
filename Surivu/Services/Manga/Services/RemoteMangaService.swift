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
    func getMangas(title: String?, limit: String?, genres: [MangaGenre]?) async throws -> [MangaEntity] {
        let queryItems = generateMangaQueryItems(title: title, limit: limit, genres: genres)
        let endpoint = MangaEndpoint.getMangas(httpParams: queryItems)
        let request = try URLRequest(endpoint: endpoint)
        return try await generateMangaEntities(request: request)
    }
    
    func getCover(coverArtId: String) async throws -> CoverEntity {
        let coverEndpoint = MangaEndpoint.getCovers(coverId: coverArtId)
        let request = try URLRequest(endpoint: coverEndpoint)
        let data = try await networkService.makeNetworkRequest(request: request)
        return try decode(APIObjectResponse<CoverEntity>.self, from: data).data
    }
    
    //MARK: - Chapters
    func getChapters(mangaId: String, limit: Int?, offset: Int) async throws -> [ChapterEntity] {
        let request = try generateChapterRequest(mangaId: mangaId, limit: limit, offset: offset)
        guard let chapterEntities: [ChapterEntity] = try await generateChapterEntities(request: request) else {
            return []
        }
        return chapterEntities
    }
    
    func getChapterImages(chapterId: String) async throws -> [String] {
        let endpoint = ChapterEndpoint.getMetadata(chapterId: chapterId)
        let request = try URLRequest(endpoint: endpoint)
        let chapterMetadataEntity = try await getChapterMetadataEntity(request: request)
        let chapterImages: [String] = chapterMetadataEntity.chapter.dataSaver.map { imageId in
            return "\(chapterMetadataEntity.baseURL)/data-saver/\(chapterMetadataEntity.chapter.hash)/\(imageId)"
        }
        return chapterImages
    }
    
    //MARK: - Helper Functions - Manga
    private func generateMangaQueryItems(title: String?, limit: String?, genres: [MangaGenre]?) -> [URLQueryItem] {
        var queries: [URLQueryItem] = []
        if let title = title {
            let titleQuery = URLQueryItem(name: "title", value: title)
            queries.append(titleQuery)
        }
        if let limit = limit {
            let titleQuery = URLQueryItem(name: "limit", value: limit)
            queries.append(titleQuery)
        }
        genres?.forEach { genre in
            queries.append(URLQueryItem(name: "includedTags[]", value: genre.id))
        }
        return queries
    }
    
    private func generateMangaEntities(request: URLRequest) async throws -> [MangaEntity] {
        let data = try await networkService.makeNetworkRequest(request: request)
        return try decode(APIListResponse<MangaEntity>.self, from: data).data
    }
    
    //MARK: - Helper Functions - Chapters
    private func getChapterMetadataEntity(request: URLRequest) async throws -> ChapterMetadataEntity {
        let data = try await networkService.makeNetworkRequest(request: request)
        return try decode(ChapterMetadataEntity.self, from: data)
    }
    
    private func generateChapterEntities(request: URLRequest) async throws -> [ChapterEntity]? {
        let data = try await networkService.makeNetworkRequest(request: request)
        return try decode(APIListResponse<ChapterEntity>.self, from: data).data
    }
    
    private func generateChapterRequest(mangaId: String, limit: Int?, offset: Int) throws -> URLRequest {
        let queries: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: String(limit ?? 12)),
            URLQueryItem(name: "manga", value: mangaId),
            URLQueryItem(name: "offset", value: String(offset)),
        ]
        let endpoint = ChapterEndpoint.getChapters(httpParams: queries)
        return try URLRequest(endpoint: endpoint)
    }
}
