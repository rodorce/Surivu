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
    let authManager: AuthManager
    let localPersistenceManager: LocalPersistenceManager
    let appState: AppState

    init() {
        self.localPersistenceManager = LocalPersistenceManager(service: KeychainService())
        self.authManager = AuthManager(service: MangaAuthService(), localPersistenceManager: localPersistenceManager)
        self.mangaManager = MangaManager(service: RemoteMangaService(networkService: ProdNetworkService()))
        self.appState = AppState()
        
        let container = DependencyContainer()
        container.register(AuthManager.self, service: authManager)
        container.register(LocalPersistenceManager.self, service: localPersistenceManager)
        container.register(MangaManager.self, service: mangaManager)
        container.register(AppState.self, service: appState)
        self.container = container
    }
}

struct DevPreview {
    static let shared = DevPreview()
    let mangaManager: MangaManager
    let authManager: AuthManager
    let localPersistenceManager: LocalPersistenceManager
    let appState: AppState
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(MangaManager.self, service: mangaManager)
        container.register(AuthManager.self, service: authManager)
        container.register(LocalPersistenceManager.self, service: localPersistenceManager)
        container.register(AppState.self, service: appState)
        return container
    }
    
    init() {
        self.mangaManager = MangaManager(service: MockMangaService())
        self.localPersistenceManager = LocalPersistenceManager(service: KeychainService())
        self.authManager = AuthManager(service: MangaAuthService(), localPersistenceManager: localPersistenceManager)
        self.appState = AppState()
    }
}

extension View {
    func previewEnvironment() -> some View {
        self
            .environment(DevPreview.shared.container)
    }
}
