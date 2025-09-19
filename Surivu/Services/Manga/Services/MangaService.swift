//
//  MangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

protocol MangaService: Sendable {
    func getMangas() async throws -> [Manga]
    func getManga(id: Int) async throws -> Manga
}
