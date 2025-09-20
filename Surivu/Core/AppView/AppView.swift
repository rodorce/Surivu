//
//  AppView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct AppView: View {
    @Environment(DependencyContainer.self) private var container
    @State var viewModel: AppViewModel
    var body: some View {
        if viewModel.interactor.showTabBar {
            TabBarView()
        }
        else {
            LogInView(viewModel: LoginViewModel(interactor: CoreInteractor(container: container)))
        }
    }
    
}

#Preview {
    let container = DevPreview.shared.container
    AppView(viewModel: AppViewModel(interactor: CoreInteractor(container: container)))
}
