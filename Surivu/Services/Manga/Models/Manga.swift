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
    
    init(id: Int, title: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
    
    static var mock: Manga {
        Manga(id: 0, title: "Test Title 1", imageUrl: "https://picsum.photo/400x300")
    }
    
    static var mocks: [Manga] {
        [
            Manga(id: 0, title: "Test Title 1", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 1, title: "Test Title 2", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 2, title: "Test Title 3", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 3, title: "Test Title 4", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 4, title: "Test Title 5", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 5, title: "Test Title 6", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 6, title: "Test Title 7", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 7, title: "Test Title 8", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 8, title: "Test Title 4", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 9, title: "Test Title 5", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 10, title: "Test Title 6", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 11, title: "Test Title 7", imageUrl: "https://picsum.photos/200/300"),
            Manga(id: 12, title: "Test Title 8", imageUrl: "https://picsum.photos/200/300"),
        ]
    }
}
