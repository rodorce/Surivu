//
//  CoversImageEndpoints.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 26/09/25.
//

import Foundation

enum CoversImageEndpoint: Endpoint {
    case getImage(mangaId: String, imageId: String)
    
    var baseURL: URL {
        URL(string: "https://uploads.mangadex.org")!
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getImage(let mangaId, let imageId):
            return "covers/\(mangaId)/\(imageId)"
        }
    }
    
    var urlQueryItems: [URLQueryItem]? { nil }
    var headers: [String : String]? { nil }
    var parameters: [String : Any]? { nil }
}
