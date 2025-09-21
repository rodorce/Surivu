//
//  MangaDetailsView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI

struct MangaDetailsView: View {
    @State var viewModel: MangaDetailsViewModel
    var mangaId: String = MangaEntity.mock.id
    var body: some View {
        ZStack {
            VStack {
                List {
                    if let manga = viewModel.manga {
                        MangaDetailsCellView(
                            title: manga.title,
                            description: manga.description,
                            imageUrl: manga.coverUrl,
                            cornerRadius: 0
                        )
                        .removeListRowFormatting()
                    }
                    Section {
                        LazyVStack(alignment: .center) {
                            //WIP: Need Model mapping to get chapters.
//                            if let chapters = viewModel.manga?.chapters {
//                                ForEach(chapters, id:\.self) { chapter in
//                                    HStack {
//                                        Text(chapter.title)
//                                            .fontWeight(.bold)
//                                        Spacer()
//                                        Text("\(chapter.pagesUrls.count) pages")
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding()
//                                    .background(Color.white)
//                                    .cornerRadius(4)
//                                }
//                            }
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
