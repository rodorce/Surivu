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
    
    init(service: MangaService) {
        self.service = service
    }
    
    func getMangas() async throws -> [Manga] {
        try await service.getMangas()
    }
    
    func getManga(id: Int) async throws -> Manga {
        try await service.getManga(id: id)
    }
}
