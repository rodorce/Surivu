//
//  NetworkService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation
import Combine

struct ProdNetworkService: NetworkService {
    func makeNetworkRequest(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode > 300 {
            throw handleError(response: httpResponse)
        }
        return data
    }
    
    private func handleError(response: HTTPURLResponse) -> LocalizedError {
        switch response.statusCode {
        case 429:
            guard let retryAfter = response.value(forHTTPHeaderField: "Retry-After") else {
                return RequestError.networkError(statusCode: response.statusCode)
            }
            return RequestError.tooManyRequests(retryAfter: Int(retryAfter))
        default:
            return RequestError.networkError(statusCode: response.statusCode)
        }
    }
}

enum RequestError: LocalizedError {
    case tooManyRequests(retryAfter: Int?)
    case networkError(statusCode: Int)
    var errorDescription: String? {
        switch self {
        case .tooManyRequests(let retryAfter):
            if let retryAfterStr = retryAfter {
                return "Something went wrong, please try again in \(retryAfterStr)"
            }
            return "Something went wrong."
        case .networkError(statusCode: let statusCode):
            return "Something went wrong. Erorr \(statusCode)"
        }
    }
}
