//
//  TabBarPathOption.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//
import SwiftUI

enum TabbarPathOption: Hashable {
    case mangaDetails(mangaId: String)
    case chapter(chapterId: String, title: String)
}

struct NavDestForTabbarViewModifier: ViewModifier {
    @Environment(DependencyContainer.self) private var dependencyContainer
    let path: Binding<[TabbarPathOption]>
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: TabbarPathOption.self) { option in
                switch option {
                case .mangaDetails(mangaId: let mangaId):
                    MangaDetailsView(viewModel: MangaDetailsViewModel(interactor: CoreInteractor(container: dependencyContainer)), mangaId: mangaId, path: path)
                case .chapter(let chapterId, let title):
                    ChapterView(chapterId: chapterId, title: title, viewModel: ChapterViewModel(interactor: CoreInteractor(container: dependencyContainer)))
                }
            }
    }
}

extension View {
    func navigationDestinationForTabbarModule(path: Binding<[TabbarPathOption]>) -> some View {
        modifier(NavDestForTabbarViewModifier(path: path))
    }
}
