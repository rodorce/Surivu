//
//  ExploreViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI

@MainActor
protocol ExploreInteractor {
    func getMangasBy(title: String?, limit: Int?) async throws -> [MangaDetail]
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
    var path: [TabbarPathOption] = []
    
    init(interactor: ExploreInteractor) {
        self.interactor = interactor
    }
    
    func loadMangas() async {
        isGridLoading = true
        do {
            mangas = try await interactor.getMangasBy(title: nil, limit: 20)
        } catch {
            print("Error retrieving mangas list \(error)")
        }
        isGridLoading = false
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
                    mangas = try await interactor.getMangasBy(title: title, limit: 12)
                } catch {
                    print("Could not retrieve searched mangas.")
                }
            isGridLoading = false
        }
    }
}
