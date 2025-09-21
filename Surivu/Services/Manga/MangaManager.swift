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
    
    func getMangasBy(title: String?, limit: Int?) async throws {
        let title = title ?? ""
        let limit = limit ?? 10
        mangas = try await service.getMangasBy(title: title, limit: String(limit))
    }
    
    func getManga(id: String) async throws -> MangaDetail {
        try await service.getManga(mangas: mangas, id: id)
    }
}
