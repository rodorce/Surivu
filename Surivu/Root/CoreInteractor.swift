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
    private let authManager: AuthManager
    private let localPersistenceManager: LocalPersistenceManager
    private let appState: AppState
    
    init(container: DependencyContainer) {
        self.mangaManager = container.resolve(MangaManager.self)!
        self.authManager = container.resolve(AuthManager.self)!
        self.localPersistenceManager = container.resolve(LocalPersistenceManager.self)!
        self.appState = container.resolve(AppState.self)!
    }
    func signInMangadex(username: String, password: String) async throws {
        try await authManager.signInMangadex(username: username, password: password)
    }
    
    func logOutMangadex() {
        authManager.logOutMangadex()
    }
    
    func getManga(id: String) async throws -> MangaDetail {
        try await mangaManager.getManga(id: id)
    }
    
    func getMangasBy(title: String?, limit: Int?) async throws -> [MangaDetail] {
        if mangaManager.mangas.isEmpty || title != nil {
            try await mangaManager.getMangasBy(title: title, limit: limit)
        }
        return mangaManager.mangas
    }
    
    var showTabBar: Bool {
        appState.showTabBar
    }
    
    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
    }
}
