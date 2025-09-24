//
//  MangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation

protocol MangaService {
    func getMangas(endpoint: String) async throws -> [MangaDetail]
    func getManga(mangas: [MangaDetail], id: String) async throws -> MangaDetail?
    func getChapters(endpoint: String) async throws -> [ChapterDetail]
    func getChapterImages(endpoint: String) async throws -> [String]
}
