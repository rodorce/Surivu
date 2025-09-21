//
//  APIResponse.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

import Foundation

struct APIListResponse<T: Codable>: Codable {
    let data: [T]
}

struct APIObjectResponse<T: Codable>: Codable {
    let data: T
}
