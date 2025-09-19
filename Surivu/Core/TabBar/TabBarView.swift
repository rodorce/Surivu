//
//  TabBarView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Tab("Explore", systemImage: "eyes") {
                Text("Explore")
            }
            Tab("Library", systemImage: "character.book.closed.fill.ja") {
                Text("Library")
            }
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                Text("Profile")
            }
        }
    }
}

#Preview {
    TabBarView()
}
