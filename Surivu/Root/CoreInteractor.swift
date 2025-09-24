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
    
    //MARK: AuthManager
    func signInMangadex(username: String, password: String) async throws {
        try await authManager.signInMangadex(username: username, password: password)
    }
    
    func logOutMangadex() {
        authManager.logOutMangadex()
    }
    
    //MARK: MangaManager
    func getManga(id: String) async throws -> MangaDetail? {
        try await mangaManager.getManga(id: id)
    }
    
    func getMangasBy(request: MangaRequest) async throws -> [MangaDetail] {
        if mangaManager.mangas.isEmpty || request.title != nil || request.genres != nil {
            try await mangaManager.getMangasBy(request: request)
            return mangaManager.mangas
        }
        return mangaManager.mangas
    }
    
    func getChapters(byMangaId: String, limit: Int?, offset: Int) async throws -> [ChapterDetail] {
        let chaptersRequest = ChapterRequest(mangaId: byMangaId, limit: String(limit ?? 100), offset: String(offset))
        return try await mangaManager.getChapters(request: chaptersRequest)
    }
    
    func getChapterImages(chapterId: String) async throws -> [String] {
        try await mangaManager.getChapterImages(chapterId: chapterId)
    }
    
    //MARK: AppStateManager
    var showTabBar: Bool {
        appState.showTabBar
    }
    
    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
    }
}
