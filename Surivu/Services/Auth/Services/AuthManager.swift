//
//  AuthManager.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import Foundation

struct AuthManager {
    let service: AuthService
    let localPersistenceManager: LocalPersistenceManager
    
    var accessToken: String? {
        guard let credentials = localPersistenceManager.get(AuthCredentials.self, forKey: "auth_credentials") else { return "" }
        return credentials.accessToken
    }
    public var refreshToken: String? {
        guard let credentials = localPersistenceManager.get(AuthCredentials.self, forKey: "auth_credentials") else { return "" }
        return credentials.refreshToken
    }
    
    init(service: AuthService, localPersistenceManager: LocalPersistenceManager) {
        self.service = service
        self.localPersistenceManager = localPersistenceManager
    }
    
    func signInMangadex(username: String, password: String) async throws {
            var authCredentials: AuthCredentials? = try await service.signInMangadex(username: username, password: password)
            let _ = localPersistenceManager.save(authCredentials, forKey: "auth_credentials")
            authCredentials = nil
        }
    
    func logOutMangadex() {
        localPersistenceManager.service.delete(forKey: "auth_credentials")
    }
    
    func refreshMangadexToken() {
        
    }
    
    func validateAccessToken() {
        
    }
}
