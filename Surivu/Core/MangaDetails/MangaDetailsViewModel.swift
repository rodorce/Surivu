//
//  MangaDetailsViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

@MainActor
protocol MangaDetailsInteractor {
    func getManga(id: String) async throws -> MangaDetail
}

extension CoreInteractor: MangaDetailsInteractor {}

@MainActor
@Observable
class MangaDetailsViewModel {
    let interactor: MangaDetailsInteractor
    var manga: MangaDetail?
    private(set) var isLoading: Bool = false
    
    init(interactor: MangaDetailsInteractor) {
        self.interactor = interactor
    }
    
    func loadManga(id: String) async {
        isLoading = true
        do {
            manga = try await interactor.getManga(id: id)
        } catch {
            print("Could not retrieve manga")
        }
        isLoading = false
    }
}
