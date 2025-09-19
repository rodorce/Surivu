//
//  Dependencies.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI

@MainActor
struct Dependencies {
    let container: DependencyContainer
    let mangaManager: MangaManager

    init() {
        self.mangaManager = MangaManager(service: MockMangaService())
        
        let container = DependencyContainer()
        container.register(MangaManager.self, service: mangaManager)
        self.container = container
    }
}

struct DevPreview {
    static let shared = DevPreview()
    let mangaManager: MangaManager
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(MangaManager.self, service: mangaManager )
        return container
    }
    
    init() {
        self.mangaManager = MangaManager(service: MockMangaService())
    }
}

extension View {
    func previewEnvironment() -> some View {
        self
            .environment(DevPreview.shared.container)
    }
}
