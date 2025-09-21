//
//  ChapterView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 21/09/25.
//

import SwiftUI

struct ChapterView: View {
    @State var chapterId: String = ""
    var title: String = ""
    @State var viewModel: ChapterViewModel
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                AsyncImage(url: URL(string: viewModel.chapterImages[viewModel.currentImage])) { phase in
                    switch phase {
                    case .empty:
                        EmptyView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                HStack {
                                    Rectangle()
                                        .opacity(0.01)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .onTapGesture {
                                            viewModel.loadPreviousImage()
                                        }
                                    Rectangle()
                                        .opacity(0.01)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .onTapGesture {
                                            viewModel.loadNextImage()
                                        }
                                }
                            }
                    case .failure:
                        Text("Could not load image")
                            .foregroundStyle(.secondary)
                    @unknown default:
                        Text("Could not load image")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                Text("\(viewModel.currentImage + 1) of \(viewModel.chapterImages.count)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
        .task {
            await viewModel.getChapterImages(chapterId: chapterId)
        }
    }
}

#Preview {
    let devPreview = DevPreview.shared.container
    ChapterView(viewModel: ChapterViewModel(interactor: CoreInteractor(container: devPreview)))
}
