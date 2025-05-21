//
//  ImageSearchDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 15/05/2025.
//

import SwiftUI

struct ImageSearchDetailView: View {
    @EnvironmentObject var searchFavorites: ImageSearchFavorites
    let item: NasaImage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: URL(string: item.fullImageURL))
                
                Text(item.title)
                    .font(.title2)

                if let desc = item.description {
                    Text(desc)
                        .font(.body)
                }
                
                Divider()

                ActionButtonsView(
                    item: item,
                    isFavorite: searchFavorites.isFavorite,
                    toggleFavorite: searchFavorites.toggle,
                    share: { _ in SharingHelper.share(url: URL(string: item.thumbnailURL)!) }
                )
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
