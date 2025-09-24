//
//  NetworkService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation
import Combine

struct ProdNetworkService: NetworkService {
    func makeNetworkRequest(endpoint: String) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint)!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
