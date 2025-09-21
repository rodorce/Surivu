//
//  NetworkService 2.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

import SwiftUI

@MainActor
protocol NetworkService {
    func makeNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> [T]
    func makeNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T
    func makeAuthNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T
    func makeAuthNetworkRequest<T: Codable>(endpoint: String, responseType: T.Type) async throws
    func makeNetworkRequestWithoutObjectResponseType<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T 
}
