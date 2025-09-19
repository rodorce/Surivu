//
//  ExploreViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//
import SwiftUI

@MainActor
protocol ExploreInteractor {
    func getMangas() async throws -> [Manga]
}

extension CoreInteractor: ExploreInteractor {}

@MainActor
@Observable
class ExploreViewModel {
    let interactor: ExploreInteractor
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private(set) var mangas: [Manga] = []
    private(set) var isGridLoading: Bool = true
    var path: [TabbarPathOption] = []

    init(interactor: ExploreInteractor) {
        self.interactor = interactor
    }
    
    func loadMangas() async {
        isGridLoading = true
        do {
            mangas = try await interactor.getMangas().sorted(by: {$0.id < $1.id})
        } catch {
            print("Error retrieving mangas list")
        }
        isGridLoading = false
    }
    
    func onPressManga(mangaId: Int) {
        path.append(.mangaDetails(mangaId: mangaId))
    }
}
