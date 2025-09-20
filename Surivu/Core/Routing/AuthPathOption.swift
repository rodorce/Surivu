//
//  AuthPathOption.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI
import Foundation

enum AuthPathOption: Hashable {
    case tabBar
}

struct NavDestForAuthViewModifier: ViewModifier {
    @Environment(DependencyContainer.self) private var dependencyContainer
    let path: Binding<[AuthPathOption]>
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AuthPathOption.self) { option in
                switch option {
                case .tabBar:
                    TabBarView()
                }
            }
    }
}

extension View {
    func navigationDestinationForTabbarModule(path: Binding<[AuthPathOption]>) -> some View {
        modifier(NavDestForAuthViewModifier(path: path))
    }
}
