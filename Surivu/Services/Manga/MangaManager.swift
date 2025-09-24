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
    
    //MARK: - Mangas
    func getMangasBy(request: MangaRequest) async throws {
        let url = try generateMangaRequest(request: request)
        mangas = try await service.getMangas(endpoint: url)
    }
    
    func getManga(id: String) async throws -> MangaDetail? {
        try await service.getManga(mangas: mangas, id: id)
    }
    
    private func generateMangaRequest(request: MangaRequest) throws -> String {
        let limit = request.limit
        var queries: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "hasAvailableChapters", value: "true"),
            URLQueryItem(name: "hasUnavailableChapters", value: "0"),
            URLQueryItem(name: "includes[]", value: "cover_art"),
            URLQueryItem(name: "includes[]", value: "manga")
        ]
        if let title = request.title {
            let titleQuery = URLQueryItem(name: "title", value: title)
            queries.append(titleQuery)
        }
        request.genres?.forEach { genre in
            queries.append(URLQueryItem(name: "includedTags[]", value: genre.id))
        }
        
        let urlComponents: String? = URLComponents(string: Endpoints.mangas)!.url?.appending(queryItems: queries).absoluteString
        return urlComponents!
    }
    
    //MARK: - Chapters
    func getChapters(request: ChapterRequest) async throws -> [ChapterDetail] {
        let endpoint = generateChapterRequest(request: request)
        return try await service.getChapters(endpoint: endpoint)
    }
    
    func getChapterImages(chapterId: String) async throws -> [String] {
        let endpoint = "\(Endpoints.chapterMetadata)/\(chapterId)"
        return try await service.getChapterImages(endpoint: endpoint)
    }
    
    private func generateChapterRequest(request: ChapterRequest) -> String {
        let queries: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: request.limit),
            URLQueryItem(name: "manga", value: request.mangaId),
            URLQueryItem(name: "offset", value: request.offset),
            URLQueryItem(name: "translatedLanguage[]", value: "en"),
            URLQueryItem(name: "order[createdAt]", value: "desc"),
            URLQueryItem(name: "order[updatedAt]", value: "desc"),
            URLQueryItem(name: "order[publishAt]", value: "desc"),
            URLQueryItem(name: "order[readableAt]", value: "desc"),
            URLQueryItem(name: "order[volume]", value: "desc"),
            URLQueryItem(name: "order[chapter]", value: "desc")
        ]
        let urlComponents: String? = URLComponents(string: Endpoints.chapter)!.url?.appending(queryItems: queries).absoluteString
        return urlComponents!
    }
}

