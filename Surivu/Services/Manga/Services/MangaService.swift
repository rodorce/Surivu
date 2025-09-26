//
//  MangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation

protocol MangaService {
    func getMangas(title: String?, limit: String?, genres: [MangaGenre]?) async throws -> [MangaEntity]
    func getChapters(mangaId: String, limit: Int?, offset: Int) async throws -> [ChapterEntity]
    func getChapterImages(chapterId: String) async throws -> [String]
    func getCover(coverArtId: String) async throws -> CoverEntity 
}
