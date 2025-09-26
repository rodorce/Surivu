//
//  APIRequest.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 23/09/25.
//

import Foundation

enum MangaEndpoint: Endpoint {
    case getMangas(httpParams: [URLQueryItem])
    case getCovers(coverId: String)
    
    var baseURL: URL {
        URL(string: "https://api.mangadex.org")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMangas, .getCovers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getMangas:
            return "manga"
        case .getCovers(let id):
            return "cover/\(id)"
        }
    }
    
    var urlQueryItems: [URLQueryItem]? {
        switch self {
        case .getMangas(let items):
            var defaultItems: [URLQueryItem] = [
                URLQueryItem(name: "hasAvailableChapters", value: "true"),
                URLQueryItem(name: "hasUnavailableChapters", value: "0"),
                URLQueryItem(name: "includes[]", value: "cover_art"),
                URLQueryItem(name: "includes[]", value: "manga")
            ]
            defaultItems.append(contentsOf: items)
            return defaultItems
        case .getCovers:
            return nil
        }
    }
    
    var headers: [String : String]? { nil }
    var parameters: [String : Any]? { nil }
}
