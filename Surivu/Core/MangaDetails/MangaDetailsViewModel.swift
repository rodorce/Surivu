//
//  MangaDetailsViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

@MainActor
protocol MangaDetailsInteractor {
    func getManga(id: Int) async throws -> Manga
}

extension CoreInteractor: MangaDetailsInteractor {}

@MainActor
@Observable
class MangaDetailsViewModel {
    let interactor: MangaDetailsInteractor
    var manga: Manga?
    
    init(interactor: MangaDetailsInteractor) {
        self.interactor = interactor
    }
    
    func loadManga(id: Int) async {
        do {
            manga = try await interactor.getManga(id: id)
        } catch {
            print("Could not retrieve manga")
        }
    }
}
