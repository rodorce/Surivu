//
//  MangaDetailsCellView.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 19/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

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
        WebImage(url: URL(string: imageUrl!)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 600)
                .blur(radius: 3)
                .overlay(alignment: .bottomLeading) {
                    mangaHeaderOverlay
                }
        } placeholder: {
            Rectangle()
                .fill(.thinMaterial)
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 600)
                .blur(radius: 3)
                .overlay(alignment: .bottomLeading) {
                    mangaHeaderOverlay
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
    }
    
    private var mangaHeaderOverlay: some View {
        ZStack(alignment: .bottomLeading) {
            Color.black.opacity(0.6)
            VStack(alignment: .leading) {
                mangaDetailsHeaderText
                    .padding(10)
                if description.count > 300 {
                    Button {
                        expandDescription.toggle()
                    } label: {
                        Text(expandDescription ? "Show less" : "Show more")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    .padding(10)
                    .buttonStyle(.bordered)
                }
            }
        }
        .frame(maxHeight: 600)
    }
}

#Preview {
    MangaDetailsCellView()
}
