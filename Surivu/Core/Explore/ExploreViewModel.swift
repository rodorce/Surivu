//
//  ExploreViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI
import Combine

protocol ExploreInteractor {
    func getMangasBy(title: String?, limit: String?, tags: [MangaTag]?) async throws -> [MangaDetail]
    func getMangaTags() async throws -> [MangaTag]
}

extension CoreInteractor: ExploreInteractor {}

@MainActor
class ExploreViewModel: ObservableObject {
    let interactor: ExploreInteractor
    let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
    ]
    
    @Published var mangas: [MangaDetail] = []
    @Published var mangaTags: [MangaTag] = []
    @Published private(set) var isGridLoading: Bool = true
    @Published private var currentTask: Task<Void, Never>? = nil
    @Published var searchText: String = ""
    @Published var selectedGenre: MangaTag = MangaTag(id: "", type: .tag, attributes: TagAttributes(name: Title(en: ""), group: .content, version: 1))
    @Published var path: [TabbarPathOption] = []
    
    init(interactor: ExploreInteractor) {
        self.interactor = interactor
    }
    
    func loadMangas() async {
        isGridLoading = true
        do {
            mangas = try await interactor.getMangasBy(title: nil, limit: "20", tags: nil)
        } catch {
            print("Error retrieving mangas list \(error)")
        }
        isGridLoading = false
    }
    
    func loadMangaTags() async {
        do {
            mangaTags = try await interactor.getMangaTags()
        } catch {
            print("Error retrieving manga tags \(error)")
        }
    }
    
    func onPressManga(mangaId: String) {
        path.append(.mangaDetails(mangaId: mangaId))
    }
    
    func searchByTitle(title: String, dismissSearch: DismissSearchAction? = nil) {
        mangas = []
        currentTask?.cancel()
        currentTask = Task {
            isGridLoading = true
            try? await Task.sleep(for: .seconds(3))
            if Task.isCancelled { return }
                do {
                    mangas = try await interactor.getMangasBy(title: title, limit: "12", tags: nil)
                } catch {
                    print("Could not retrieve searched mangas.")
                }
            isGridLoading = false
        }
    }
    
    func filterMangaByTag(tag: MangaTag) {
        Task {
            isGridLoading = true
            do {
                mangas = try await interactor.getMangasBy(title: nil, limit: "12", tags: [tag])
            } catch {
                print("Could not filter mangas \(error)")
            }
            isGridLoading = false
        }
    }
}
