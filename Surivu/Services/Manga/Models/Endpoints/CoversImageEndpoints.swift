//
//  CoversImageEndpoints.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 26/09/25.
//
import Foundation

protocol CoversImageEndpointsProtocol: Endpoint {}

extension CoversImageEndpointsProtocol {
    var baseURL: URL {URL(string: "https://uploads.mangadex.org")!}
    var method: HTTPMethod { .get }
    var parameters: [String : Any]? { nil }
    var headers: [String : String]? { nil }
    var urlQueryItems: [URLQueryItem]? { nil }
}

struct CoversImageEndpoint: CoversImageEndpointsProtocol {
    var path: String
}
