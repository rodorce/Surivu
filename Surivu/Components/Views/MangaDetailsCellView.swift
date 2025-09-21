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
        mangaDetailsHeader
            .ignoresSafeArea()
    }
    
    private var mangaDetailsHeader: some View {
        ZStack {
            if let imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                ZStack(alignment: .bottomLeading) {
                                    Color.black.opacity(0.6)
                                    mangaDetailsHeaderText
                                }
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                ZStack(alignment: .bottomLeading) {
                                    Color.black.opacity(0.6)
                                    mangaDetailsHeaderText
                                }
                            }
                        
                    case .failure:
                        Rectangle()
                            .fill(.thinMaterial)
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                ZStack(alignment: .bottomLeading) {
                                    Color.black.opacity(0.6)
                                    mangaDetailsHeaderText
                                }
                            }
                    @unknown default:
                        Rectangle()
                            .fill(.thinMaterial)
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .overlay(alignment: .bottomLeading) {
                                ZStack(alignment: .bottomLeading) {
                                    Color.black.opacity(0.6)
                                    mangaDetailsHeaderText
                                }
                            }
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
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .shadow(radius: 3)
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .minimumScaleFactor(0.5)
                    .shadow(radius: 5)
            }
        }
        .padding(16)
    }
}

#Preview {
    MangaDetailsCellView()
}
