//
//  APODDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 12/05/2025.
//

import SwiftUI

struct APODDetailView: View {
    @EnvironmentObject var apodFavorites: APODFavorites
    let apod: APOD

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: URL(string: apod.url))
                
                Text(apod.title)
                    .font(.title2)

                Text(apod.explanation)
                    .font(.body)
                
                Divider()
                
                ActionButtonsView(
                    item: apod,
                    isFavorite: apodFavorites.isFavorite,
                    toggleFavorite: apodFavorites.toggle,
                    share: { _ in SharingHelper.share(url: URL(string: apod.url)!) }
                )
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
