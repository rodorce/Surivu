//
//  ExploreView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

struct ExploreView: View {
    @State var viewModel: ExploreViewModel
    @Environment(\.dismissSearch) private var dismissSearch
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                if viewModel.isGridLoading {
                    Text("Retrieving mangas...")
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                LazyVGrid(columns: viewModel.columns, spacing: 10) {
                    ForEach(viewModel.mangas, id:\.id) { manga in
                        VStack {
                            if let coverUrl = manga.coverUrl {
                                image(imageUrl: coverUrl, mangaTitle: manga.title)
                            }
                        }
                        .onTapGesture {
                            viewModel.onPressManga(mangaId: manga.id)
                        }
                        .redacted(reason: viewModel.isGridLoading ? .placeholder : [])
                    }
                }
                .padding(.horizontal, 2)
                .task {
                    await viewModel.loadMangas()
                }
            }
            .navigationTitle("Explore")
            .navigationDestinationForTabbarModule(path: $viewModel.path)
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText, { _, newValue in
            viewModel.searchByTitle(title: newValue, dismissSearch: dismissSearch)
        })
    }
    
    private func image(imageUrl: String, mangaTitle: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .cornerRadius(8)
                    .overlay(alignment: .bottomLeading, content: {
                        Text(mangaTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.vertical, 3)
                            .font(.title3)
                            .lineLimit(3)
                            .frame(maxWidth: .infinity)
                            .addingGradientBackgroundForText()
                            .clipped()
                    })
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
