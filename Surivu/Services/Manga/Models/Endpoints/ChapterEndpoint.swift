//
//  ChapterEndpoint.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 26/09/25.
//

import Foundation

enum ChapterEndpoint: Endpoint {
    case getChapters(httpParams: [URLQueryItem])
    case getMetadata(chapterId: String)
    
    var baseURL: URL {
        URL(string: "https://api.mangadex.org")!
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getChapters:
            return "chapter"
        case .getMetadata(let chapterId):
            return "at-home/server/\(chapterId)"
        }
    }
    
    var urlQueryItems: [URLQueryItem]? {
        switch self {
        case .getChapters(let items):
            var defaultItems: [URLQueryItem] = [
                URLQueryItem(name: "translatedLanguage[]", value: "en"),
                URLQueryItem(name: "order[createdAt]", value: "desc"),
                URLQueryItem(name: "order[updatedAt]", value: "desc"),
                URLQueryItem(name: "order[publishAt]", value: "desc"),
                URLQueryItem(name: "order[readableAt]", value: "desc"),
                URLQueryItem(name: "order[volume]", value: "desc"),
                URLQueryItem(name: "order[chapter]", value: "desc")
            ]
            defaultItems.append(contentsOf: items)
            return defaultItems
        case .getMetadata:
            return nil
        }
    }
    
    var headers: [String : String]? { nil }
    var parameters: [String : Any]? { nil }
}
