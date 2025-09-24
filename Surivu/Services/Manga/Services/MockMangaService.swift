//
//  MockMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation

struct MockMangaService: MangaService {
    func getMangas(endpoint: String) async throws -> [MangaDetail] {
        MangaDetail.mocks
    }
    
    func getManga(mangas: [MangaDetail], id: String) async throws -> MangaDetail? {
        MangaDetail.mock
    }
    
    func getChapters(endpoint: String) async throws -> [ChapterDetail] {
        ChapterDetail.mocks
    }
    
    func getChapterImages(endpoint: String) async throws -> [String] {
        [Constants.randomImageUrl, Constants.randomImageUrl]
    }
}
