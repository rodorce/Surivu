//
//  AuthService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

protocol AuthService {
    func signInMangadex(username: String, password: String) async throws -> AuthCredentials
    func logout()
}

class MangaAuthService: AuthService {
    func signInMangadex(username: String, password: String) async throws -> AuthCredentials {
        guard let url = URL(string:"https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/token") else {
            throw URLError(.badURL)
        }
        
        do {
            let loginFormData = try LoginRequest(username: username, password: password).asFormURLEncoded()
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = loginFormData
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let (data, response) = try await URLSession.shared.data(for: request)
            let authCredentials = try JSONDecoder().decode(AuthCredentials.self, from: data)
            return authCredentials
        } catch {
            throw error
        }
    }
    
    func logout() {
        
    }
    
    
}
