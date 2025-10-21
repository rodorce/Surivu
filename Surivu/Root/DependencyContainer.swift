//
//  DependencyContainer.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI
import Combine

class DependencyContainer: ObservableObject {
    private var services: [String: Any] = [:]
    
    func register<T>(_ type: T.Type, service: T) {
        let key = "\(type)"
        services[key] = service
    }
    func resolve<T>(_ type: T.Type) -> T? {
        let key = "\(type)"
        return services[key] as? T
    }
}
