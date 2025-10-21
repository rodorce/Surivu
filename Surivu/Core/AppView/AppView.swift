//
//  AppView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject private var container: DependencyContainer
    @State var viewModel: AppViewModel
    var body: some View {
        TabBarView()
    }
    
}

#Preview {
    let container = DevPreview.shared.container
    AppView(viewModel: AppViewModel(interactor: CoreInteractor(container: container)))
}
