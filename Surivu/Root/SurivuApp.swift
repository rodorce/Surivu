//
//  SurivuApp.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

@main
struct SurivuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView(viewModel: AppViewModel(interactor: CoreInteractor(container: delegate.dependencies.container)))
                .environmentObject(delegate.dependencies.container)
        }
    }
}
