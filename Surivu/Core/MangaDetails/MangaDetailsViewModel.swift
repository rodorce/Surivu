//
//  MangaDetailsViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI
import Combine

protocol MangaDetailsInteractor {
    func getManga(id: String) async throws -> MangaDetail?
    func getChapters(byMangaId: String, limit: Int?, offset: Int) async throws -> [ChapterDetail]
}

extension CoreInteractor: MangaDetailsInteractor {}

@MainActor
class MangaDetailsViewModel: ObservableObject {
    let interactor: MangaDetailsInteractor
    @Published var manga: MangaDetail?
    @Published var chapters: [ChapterDetail]?
    @Published var offset: Int = 0
    @Published private(set) var isLoading: Bool = false
    func formatChapterTitle(title: String, chapterNumber: String) -> String {
        title.isEmpty ? "Chapter \(chapterNumber)" : "\(chapterNumber) \(title)"
    }
    
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
    
    func loadChapters(mangaId: String, limit: Int) async {
        do {
            guard (chapters == nil) else {
                let offset = offset
                let retrievedChapters = try await interactor.getChapters(byMangaId: mangaId, limit: limit, offset: offset)
                chapters?.append(contentsOf: retrievedChapters)
                return
            }
            chapters = try await interactor.getChapters(byMangaId: mangaId, limit: limit, offset: offset)
            return
        } catch {
            print("Could not retrieve chapters. \(error)")
        }
    }
    
    func onChapterPressed(chapterId: String, title: String, path: Binding<[TabbarPathOption]>) {
        path.wrappedValue.append(.chapter(chapterId: chapterId, title: title))
    }
}
