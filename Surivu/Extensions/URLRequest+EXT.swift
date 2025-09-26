//
//  URLRequest+EXT.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 25/09/25.
//

import Foundation

extension URLRequest {
    init(endpoint: Endpoint) throws {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)

        if let urlQueryItems = endpoint.urlQueryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = urlQueryItems
            if let urlWithQuery = components?.url {
                url = urlWithQuery
            }
        }

        self.init(url: url)
        self.httpMethod = endpoint.method.rawValue

        if let headers = endpoint.headers {
            for (key, value) in headers {
                self.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}
