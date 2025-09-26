//
//  ChapterViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//
import SwiftUI
import Combine

protocol ChapterInteractor {
    func getChapterImages(chapterId: String) async throws -> [String]
}

extension CoreInteractor: ChapterInteractor {}

@MainActor
class ChapterViewModel: ObservableObject {
    @Published var chapterImages: [String] = []
    @Published var currentImage: Int = 0
    let interactor: ChapterInteractor
    
    init(interactor: ChapterInteractor) {
        self.interactor = interactor
    }
    
    func loadNextImage() {
        if currentImage < chapterImages.count - 1 {
            currentImage += 1
        }
    }
    
    func loadPreviousImage() {
        if currentImage > 0 {
            currentImage -= 1
        }
    }
    
    func getChapterImages(chapterId: String) async {
        do {
            chapterImages = try await interactor.getChapterImages(chapterId: chapterId)
        } catch {
            print("Could not retrieve chapter images.")
        }
    }
}
