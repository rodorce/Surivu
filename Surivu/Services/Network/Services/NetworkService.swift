//
//  NetworkService 2.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//

import SwiftUI

protocol NetworkService {
    func makeNetworkRequest(request: URLRequest) async throws -> Data
}
