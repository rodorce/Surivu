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
    private(set) var mangas: [Manga] = []
    
    init(service: MangaService) {
        self.service = service
    }
    
    func getMangas() async throws {
        self.mangas = try await service.getMangas()
    }
    
    func getManga(id: Int) async throws -> Manga {
        try await service.getManga(id: id)
    }
}
