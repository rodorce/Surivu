//
//  AppView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct AppView: View {
    @State var showTabBar: Bool = true
    var body: some View {
        AppViewBuilder(showTabBar: showTabBar, tabbarView: {
            TabBarView()
        }, onboardingView: {
            EmptyView()
        })
    }
    
}

#Preview {
    AppView()
}
