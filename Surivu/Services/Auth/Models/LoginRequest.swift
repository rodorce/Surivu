//
//  LoginRequest.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import Foundation

struct LoginRequest: Encodable {
    let grantType: String
    let username: String
    let password: String
    let clientId: String
    let clientSecret: String
    
    init(username: String, password: String) {
        self.grantType = "password"
        self.username = username
        self.password = password
        self.clientId = "personal-client-10fbf75d-f497-4f3c-86a2-19311bca5694-cd77558d"
        self.clientSecret = "awXGVoWHsgw0mHzRnv0IgxcTiLZQ4UsZ"
    }
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case grantType = "grant_type"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}
