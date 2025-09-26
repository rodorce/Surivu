//
//  MangaDetailsView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI
import Combine
struct MangaDetailsView: View {
    @StateObject var viewModel: MangaDetailsViewModel
    var mangaId: String = MangaEntity.mock.id
    @Binding var path: [TabbarPathOption]
    var body: some View {
        ZStack {
            VStack {
                List {
                    if let manga = viewModel.manga {
                        MangaDetailsCellView(
                            title: manga.title,
                            description: manga.description,
                            imageUrl: manga.coverUrl,
                            cornerRadius: 0,
                            genres: manga.genres
                        )
                        .removeListRowFormatting()
                    }
                    Section {
                        LazyVStack(alignment: .center) {
                            if let chapters = viewModel.chapters {
                                ForEach(chapters, id:\.id) { chapter in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(viewModel.formatChapterTitle(title: chapter.title, chapterNumber: chapter.chapter))
                                                .fontWeight(.bold)
                                                .font(.subheadline)
                                            Text(chapter.createdAt.formatted(date: .abbreviated, time: .omitted))
                                                .fontWeight(.semibold)
                                                .font(.caption)
                                        }
                                        Spacer()
                                        Text(chapter.translatedLanguage)
                                            .padding(.trailing, 10)
                                            .font(.caption)
                                        Text("\(chapter.pages) pages")
                                            .font(.caption)
                                    }
                                    .onTapGesture(perform: {
                                        let title = viewModel.formatChapterTitle(title: chapter.title, chapterNumber: chapter.chapter)
                                        viewModel.onChapterPressed(chapterId: chapter.id, title: title, path: $path)
                                    })
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color(uiColor: .secondarySystemBackground))
                                    .cornerRadius(4)
                                }
                                if let lastChapter = viewModel.manga?.lastChapter {
                                    if lastChapter > viewModel.offset {
                                        showMoreChaptersBtn
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .listRowBackground(Color.clear)
                    } header: {
                        Text("Chapters")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                    }
                    .listRowInsets(EdgeInsets(top: 3, leading: 7, bottom: 3, trailing: 7))
                }
                .listStyle(PlainListStyle())
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .task {
            await viewModel.loadManga(id: mangaId)
            await viewModel.loadChapters(mangaId: mangaId, limit: 100)
        }
        
    }
    
    private var showMoreChaptersBtn: some View {
        Button {
            Task {
                viewModel.offset += 100
                await viewModel.loadChapters(mangaId: mangaId, limit: 100)
                
            }
        } label: {
            Text("Show more chapters")
        }
        .isHidden(!(viewModel.manga?.lastChapter ?? 0 > viewModel.offset), remove: true)
    }
}

#Preview {
    let container = DevPreview.shared.container
    MangaDetailsView(viewModel: MangaDetailsViewModel(interactor: CoreInteractor(container: container)), path: .constant([]))
}
