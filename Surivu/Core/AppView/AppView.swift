struct AppView: View {
    @State private var showTabBar: Bool = false
    var body: some View {
        AppViewBuilder(showTabBar: showTabBar, tabbarView: {
            EmptyView()
        }, onboardingView: {
            EmptyView()
        })
    }
    
}