//
//  ExploreViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI

@MainActor
protocol ExploreInteractor {
    func getMangasBy(request: MangaRequest) async throws -> [MangaDetail]
}

extension CoreInteractor: ExploreInteractor {}

@MainActor
@Observable
class ExploreViewModel {
    let interactor: ExploreInteractor
    let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
    ]
    
    var mangas: [MangaDetail] = []
    private(set) var isGridLoading: Bool = true
    private var currentTask: Task<Void, Never>? = nil
    var searchText: String = ""
    var selectedGenre: MangaGenre = .romance
    var path: [TabbarPathOption] = []
    
    init(interactor: ExploreInteractor) {
        self.interactor = interactor
    }
    
    func loadMangas() async {
        let request = MangaRequest(title: nil, limit: "20", genres: nil)
        isGridLoading = true
        do {
            mangas = try await interactor.getMangasBy(request: request)
        } catch {
            print("Error retrieving mangas list \(error)")
        }
        isGridLoading = false
    }
    
    func onPressManga(mangaId: String) {
        path.append(.mangaDetails(mangaId: mangaId))
    }
    
    func searchByTitle(title: String, dismissSearch: DismissSearchAction? = nil) {
        let request = MangaRequest(title: title, limit: "12", genres: nil)
        mangas = []
        currentTask?.cancel()
        currentTask = Task {
            isGridLoading = true
            try? await Task.sleep(for: .seconds(3))
            if Task.isCancelled { return }
                do {
                    mangas = try await interactor.getMangasBy(request: request)
                } catch {
                    print("Could not retrieve searched mangas.")
                }
            isGridLoading = false
        }
    }
    
    func filterMangaByGenre(genre: MangaGenre) {
        let request: MangaRequest = MangaRequest(
            title: nil,
            limit: String(12),
            genres: [genre]
        )
        Task {
            isGridLoading = true
            do {
                print(mangas.count)
                mangas = try await interactor.getMangasBy(request: request)
                print(mangas.count)
            } catch {
                print("Could not filter mangas \(error)")
            }
            isGridLoading = false
        }
    }
    
    func loadGenreTags() {
//        interactor.getGenreTags()
    }
}
