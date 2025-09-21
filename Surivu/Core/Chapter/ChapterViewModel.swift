//
//  ChapterViewModel.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//
import SwiftUI

protocol ChapterInteractor {
    func getChapterImages(chapterId: String) async throws -> [String]
}

extension CoreInteractor: ChapterInteractor {}

@MainActor
@Observable
class ChapterViewModel {
    var chapterImages: [String] = [""]
    var currentImage: Int = 0
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
