//
//  ExploreView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct ExploreView: View {
    @State var viewModel: ExploreViewModel
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach(viewModel.mangas, id:\.self) { manga in
                        VStack {
                            image(imageUrl: manga.imageUrl)
                            Text(manga.title)
                                .font(.headline)
                        }
                        .onTapGesture {
                            viewModel.onPressManga(mangaId: manga.id)
                        }
                        .padding(.vertical, 10)
                        .redacted(reason: viewModel.isGridLoading ? .placeholder : [])
                    }
                }
                .padding(.horizontal, 16)
                .task {
                    await viewModel.loadMangas()
                }
            }
            .navigationTitle("Explore")
            .navigationDestinationForTabbarModule(path: $viewModel.path)
        }
    }
    
    private func image(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(8)
                    .shadow(radius: 16)
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    ExploreView(viewModel: ExploreViewModel(interactor: CoreInteractor(container: container)))
        .previewEnvironment()
}
