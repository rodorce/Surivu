//
//  MangaDetailsCellView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI

struct MangaDetailsCellView: View {
    var title: String? = "Sample title"
    var description: String = "Description for the manga."
    var imageUrl: String? = Constants.randomImageUrl
    var cornerRadius: CGFloat = 16
    @State var expandDescription: Bool = false
    
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
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .blur(radius: 3)
                            .overlay(alignment: .bottomLeading) {
                                mangaHeaderOverlay
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .blur(radius: 3)
                            .overlay(alignment: .bottomLeading) {
                                mangaHeaderOverlay
                            }
                        
                    case .failure:
                        Rectangle()
                            .fill(.thinMaterial)
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 600)
                            .blur(radius: 3)
                            .overlay(alignment: .bottomLeading) {
                                mangaHeaderOverlay
                            }
                    @unknown default:
                        Rectangle()
                            .fill(.thinMaterial)
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 570)
                            .overlay(alignment: .bottomLeading) {
                                ZStack(alignment: .bottomLeading) {
                                    Color.black.opacity(0.6)
                                    VStack {
                                        mangaDetailsHeaderText
                                        Button {
                                            expandDescription.toggle()
                                        } label: {
                                            Text(expandDescription ? "Show less" : "Show more")
                                        }
                                    }
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
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                    .lineLimit(expandDescription ? nil : 6)
                    .animation(.easeInOut, value: expandDescription)
            }
        }
        .padding(16)
    }
    
    private var mangaHeaderOverlay: some View {
        ZStack(alignment: .bottomLeading) {
            Color.black.opacity(0.6)
            VStack(alignment: .leading) {
                mangaDetailsHeaderText
                if description.count > 300 {
                    Button {
                        expandDescription.toggle()
                    } label: {
                        Text(expandDescription ? "Show less" : "Show more")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.bordered)
                    .backgroundStyle(.blue)
                }
            }
        }
        .frame(maxHeight: 600)
    }
}

#Preview {
    MangaDetailsCellView()
}
