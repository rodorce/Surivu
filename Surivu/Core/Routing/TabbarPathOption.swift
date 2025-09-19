//
//  TabBarPathOption.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

enum TabbarPathOption: Hashable {
    case chapters(mangaId: Int)
    case chapter(mangaId: Int, chapterId: Int)
}

struct NavDestForTabbarViewModifier: ViewModifier {
    @Environment(DependencyContainer.self) private var dependencyContainer
    let path: Binding<[TabbarPathOption]>
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: TabbarPathOption.self) { option in
                switch option {
                case .chapters(mangaId: let mangaId):
                    Text("Chapters List View \(mangaId)")
                case .chapter(mangaId: let mangaId, chapterId: let chapterId):
                    Text("Chapter Overview \(mangaId) \(chapterId)")
                }
            }
    }
}

extension View {
    func navigationDestinationForTabbarModule(path: Binding<[TabbarPathOption]>) -> some View {
        modifier(NavDestForTabbarViewModifier(path: path))
    }
}
