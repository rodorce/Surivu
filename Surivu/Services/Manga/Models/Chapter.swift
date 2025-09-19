//
//  Chapters.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

struct Chapter: Codable, Hashable {
    let title: String
    let pagesUrls: [String]
    
    init(title: String, pagesUrls: [String]) {
        self.title = title
        self.pagesUrls = pagesUrls
    }
    
    static var chaptersMock: [Chapter] {
        [
            Chapter(title: "Chapter Sample 1", pagesUrls: [
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
            ]),
            Chapter(title: "Chapter Sample 2", pagesUrls: [
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
            ]),
            Chapter(title: "Chapter Sample 3", pagesUrls: [
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl
            ]),
            Chapter(title: "Chapter Sample 4", pagesUrls: [
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl,
                Constants.randomImageUrl
            ])
        ]
    }
}
