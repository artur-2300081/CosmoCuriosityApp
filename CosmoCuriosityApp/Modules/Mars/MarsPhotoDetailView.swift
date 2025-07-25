//
//  MarsPhotoDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 13/05/2025.
//

import SwiftUI

struct MarsPhotoDetailView: View {
    @EnvironmentObject var marsFavorites: MarsFavorites
    let photo: MarsPhoto

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: URL(string: photo.imgSrc))
                
                Text("Camera: \(photo.camera.fullName)")
                    .font(.headline)

                Text("Rover: \(photo.rover.name)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Date: \(photo.earthDate)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Divider()

                ActionButtonsView(
                    item: photo,
                    isFavorite: marsFavorites.isFavorite,
                    toggleFavorite: marsFavorites.toggle,
                    share: { _ in SharingHelper.share(url: URL(string: photo.imgSrc)!) }
                )
            }
            .padding()
        }
        .navigationTitle("Mars Photo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
