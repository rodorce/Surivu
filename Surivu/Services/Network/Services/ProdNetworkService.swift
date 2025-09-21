//
//  NetworkService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation

struct ProdNetworkService: NetworkService {
    func makeNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint)!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        print("DATA", String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse = try decoder.decode(APIListResponse<T>.self, from: data)
        return apiResponse.data
    }
    
    func makeNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint)!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        print("DATA", String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse = try decoder.decode(APIObjectResponse<T>.self, from: data)
        return apiResponse.data
    }
    
    func makeNetworkRequestWithoutObjectResponseType<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint)!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        print("DATA", String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse = try decoder.decode(T.self, from: data)
        return apiResponse
    }
    
    func makeAuthNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.addValue("Bearer", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResponse = try decoder.decode(APIObjectResponse<T>.self, from: data)
        return apiResponse.data
    }
    
    func makeAuthNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws {
    }
}
