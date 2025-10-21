//
//  CoreInteractor.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

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
         await mangaManager.getManga(id: id)
    }
    
    func getMangaTags() async throws -> [MangaTag] {
        try await mangaManager.getMangaTags()
    }
    
    func getMangasBy(title: String?, limit: String?, tags: [MangaTag]?) async throws -> [MangaDetail] {
        if await mangaManager.mangas.isEmpty || title != nil || tags != nil {
            try await mangaManager.getMangasBy(title: title, limit: "12", tags: tags)
            return await mangaManager.mangas
        }
        return await mangaManager.mangas
    }
    
    func getChapters(byMangaId: String, limit: Int?, offset: Int) async throws -> [ChapterDetail] {
        return try await mangaManager.getChapters(mangaId: byMangaId, limit: limit, offset: offset)
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
