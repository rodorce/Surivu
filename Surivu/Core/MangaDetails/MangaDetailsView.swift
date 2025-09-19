//
//  MangaDetailsView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI

struct MangaDetailsView: View {
    @State var viewModel: MangaDetailsViewModel
    var mangaId: Int = Manga.mock.id
    var body: some View {
        ZStack {
            LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.92, green: 0.91, blue: 0.90),
                                Color(red: 1, green: 1, blue: 1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
            .ignoresSafeArea()
            VStack {
                List {
                    if let manga = viewModel.manga {
                        MangaDetailsCellView(
                            title: manga.title,
                            description: manga.description,
                            imageUrl: manga.imageUrl,
                            cornerRadius: 0
                        )
                        .removeListRowFormatting()
                    }
                    Section {
                        LazyVStack(alignment: .center) {
                            if let chapters = viewModel.manga?.chapters {
                                ForEach(chapters, id:\.self) { chapter in
                                    HStack {
                                        Text(chapter.title)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Text("\(chapter.pagesUrls.count) pages")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(4)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowBackground(Color.clear)
                    } header: {
                        Text("Chapters")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .listRowInsets(EdgeInsets(top: 3, leading: 7, bottom: 3, trailing: 7))
                }
                .ignoresSafeArea()
                .listStyle(PlainListStyle())
            }
        }
        .task {
            await viewModel.loadManga(id: mangaId)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    MangaDetailsView(viewModel: MangaDetailsViewModel(interactor: CoreInteractor(container: container)))
}
