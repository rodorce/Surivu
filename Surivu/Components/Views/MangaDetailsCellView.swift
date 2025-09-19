//
//  MangaDetailsCellView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI

struct MangaDetailsCellView: View {
    var title: String? = "Sample title"
    var description: String? = "Description for the manga."
    var imageUrl: String? = Constants.randomImageUrl
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        VStack {
            mangaDetailsHeader
        }
        .ignoresSafeArea()
    }
    
    private var mangaDetailsHeader: some View {
        ZStack {
            if let imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(alignment: .bottomLeading) {
                                mangaDetailsHeaderText
                            }
                            .cornerRadius(cornerRadius)

                    case .failure:
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                mangaDetailsHeaderText
                            }
                            .cornerRadius(cornerRadius)
                    @unknown default:
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                mangaDetailsHeaderText
                            }
                            .cornerRadius(cornerRadius)
                    }
                }
            }
            else {
                Rectangle()
                    .fill(.thinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: 600)
                    .overlay(alignment: .bottomLeading) {
                        mangaDetailsHeaderText
                    }
            }
        }
    }
    
    private var mangaDetailsHeaderText: some View {
        VStack {
            if let title, let description {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(3)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(3)
        }
        }
        .padding(16)
        .addingGradientBackgroundForText()
    }
}

#Preview {
    MangaDetailsCellView()
}
