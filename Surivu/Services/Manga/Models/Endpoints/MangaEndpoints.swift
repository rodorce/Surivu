//
//  APIRequest.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 23/09/25.
//
import Foundation

protocol MangaEndpointProtocol: Endpoint {}

extension MangaEndpointProtocol {
    var baseURL: URL {
        URL(string: "https://api.mangadex.org")!
    }
    var headers: [String : String]? {
        nil
    }
    var parameters: [String : Any]? {
        nil
    }
}

struct GetMangasEndpoint: MangaEndpointProtocol {
    var method: HTTPMethod = .get
    var path: String = "manga"
    var urlQueryItems: [URLQueryItem]? = [
        URLQueryItem(name: "hasAvailableChapters", value: "true"),
        URLQueryItem(name: "hasUnavailableChapters", value: "0"),
        URLQueryItem(name: "includes[]", value: "cover_art"),
        URLQueryItem(name: "includes[]", value: "manga")
    ]
    
    init(method: HTTPMethod = .get, urlQueryItems: [URLQueryItem]) {
        var defaultItems: [URLQueryItem] = [
            URLQueryItem(name: "hasAvailableChapters", value: "true"),
            URLQueryItem(name: "hasUnavailableChapters", value: "0"),
            URLQueryItem(name: "includes[]", value: "cover_art"),
            URLQueryItem(name: "includes[]", value: "manga")
        ]
        defaultItems.append(contentsOf: urlQueryItems)
        self.method = method
        self.urlQueryItems = defaultItems
    }
}

struct MangaCoversEndpoint: MangaEndpointProtocol {
    var method: HTTPMethod = .get
    var urlQueryItems: [URLQueryItem]? = nil
    var path: String
}

struct ChaptersEndpoint: MangaEndpointProtocol {
    var path: String = "chapter"
    var method: HTTPMethod = .get
    var urlQueryItems: [URLQueryItem]?
    
    init(urlQueryItems: [URLQueryItem]) {
        self.urlQueryItems = urlQueryItems
        let defaultItems: [URLQueryItem] = [
            URLQueryItem(name: "translatedLanguage[]", value: "en"),
            URLQueryItem(name: "order[createdAt]", value: "desc"),
            URLQueryItem(name: "order[updatedAt]", value: "desc"),
            URLQueryItem(name: "order[publishAt]", value: "desc"),
            URLQueryItem(name: "order[readableAt]", value: "desc"),
            URLQueryItem(name: "order[volume]", value: "desc"),
            URLQueryItem(name: "order[chapter]", value: "desc")
        ]
        self.urlQueryItems?.append(contentsOf: defaultItems)
    }
}

struct ChaptersMetadataEndpoint: MangaEndpointProtocol {
    var method: HTTPMethod = .get
    var urlQueryItems: [URLQueryItem]? = nil
    var path: String
}
