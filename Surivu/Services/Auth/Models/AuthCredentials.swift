//
//  AuthCredentials.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import Foundation

struct AuthCredentials: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshExpiresIn: Int
    let refreshToken: String
    let tokenType: String
    let notBeforePolicy: Int
    let sessionState: String
    let scope: String
    let clientType: String
    
    init(accessToken: String, expiresIn: Int, refreshExpiresIn: Int, refreshToken: String, tokenType: String, notBeforePolicy: Int, sessionState: String, scope: String, clientType: String) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.refreshExpiresIn = refreshExpiresIn
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.notBeforePolicy = notBeforePolicy
        self.sessionState = sessionState
        self.scope = scope
        self.clientType = clientType
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
        case clientType = "client_type"
    }
}
