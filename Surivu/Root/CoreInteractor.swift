//
//  CoreInteractor.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

@MainActor
struct CoreInteractor {
    private let mangaManager: MangaManager
    
    init(container: DependencyContainer) {
        self.mangaManager = container.resolve(MangaManager.self)!
    }
    
    func getManga(id: Int) async throws -> Manga {
        try await mangaManager.getManga(id: id)
    }
    
    func getMangas() async throws -> [Manga] {
        if mangaManager.mangas.isEmpty {
            try await mangaManager.getMangas()
        }
        return mangaManager.mangas
    }
}
