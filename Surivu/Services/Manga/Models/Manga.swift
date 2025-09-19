//
//  Manga.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

struct Manga: Codable, Hashable {
    let id: Int
    let title: String
    let imageUrl: String
    let description: String
    let chapters: [Chapter]
    
    init(id: Int, title: String, imageUrl: String, description: String, chapters: [Chapter]) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.description = description
        self.chapters = chapters
    }
    
    static var mock: Manga {
        Manga(id: 0, title: "Test Title 1", imageUrl: "https://picsum.photo/400x300", description: "Sample Description", chapters: Chapter.chaptersMock)
    }
    
    static var mocks: [Manga] {
        [
            Manga(id: 0, title: "Test Title 1", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 1, title: "Test Title 2", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 2, title: "Test Title 3", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 3, title: "Test Title 4", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 4, title: "Test Title 5", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 5, title: "Test Title 6", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 6, title: "Test Title 7", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 7, title: "Test Title 8", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 8, title: "Test Title 9", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 9, title: "Test Title 10", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 10, title: "Test Title 11", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 11, title: "Test Title 12", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock),
            Manga(id: 12, title: "Test Title 13", imageUrl: "https://picsum.photos/200/300", description: "Sample Description", chapters: Chapter.chaptersMock)
        ]
    }
}
