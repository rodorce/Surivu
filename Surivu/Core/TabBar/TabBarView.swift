//
//  TabBarView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct TabBarView: View {
    @Environment(DependencyContainer.self) private var container
    var body: some View {
        TabView {
            Tab("Explore", systemImage: "eyes") {
                ExploreView(viewModel: ExploreViewModel(interactor: CoreInteractor(container: container)))
            }
            Tab("Library", systemImage: "character.book.closed.fill.ja") {
                LibraryView()
            }
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                ProfileView()
            }
        }
    }
}

#Preview {
    TabBarView()
}
