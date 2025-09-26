//
//  ExploreView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    @StateObject var viewModel: ExploreViewModel
    @Environment(\.dismissSearch) private var dismissSearch
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MangaGenre.allCases, id: \.self) { genre in
                            Text(genre.rawValue)
                                .tag(genre)
                                .padding(10)
                                .background(Color(uiColor: .secondarySystemBackground))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.filterMangaByGenre(genre: genre)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 10)
                if viewModel.isGridLoading {
                    VStack {
                        ProgressView()
                        Text("Retrieving mangas...")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(viewModel.mangas, id:\.id) { manga in
                            if let coverUrl = manga.coverUrl {
                                image(imageUrl: coverUrl, mangaTitle: manga.title)
                                    .onTapGesture {
                                        viewModel.onPressManga(mangaId: manga.id)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 2)
                    .task {
                        await viewModel.loadMangas()
                    }
                }
                
            }
            .navigationTitle("Explore")
            .navigationDestinationForTabbarModule(path: $viewModel.path)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchText, { _, newValue in
                viewModel.searchByTitle(title: newValue, dismissSearch: dismissSearch)
            })
        }

    }
    
    private func placeholderImage(title: String) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .frame(height: 280)
            .cornerRadius(8)
            .overlay(alignment: .bottomLeading, content: {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 3)
                    .font(.title3)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity)
                    .addingGradientBackgroundForText()
                    .clipped()
            })
            .redacted(reason: .placeholder)
    }
    private func image(imageUrl: String, mangaTitle: String) -> some View {
        return WebImage(url: URL(string: imageUrl)) { image in
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
        } placeholder: {
            placeholderImage(title: mangaTitle)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    ExploreView(viewModel: ExploreViewModel(interactor: CoreInteractor(container: container)))
        .previewEnvironment()
}
