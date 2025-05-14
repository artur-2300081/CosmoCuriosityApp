//
//  MarsPhotoDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 13/05/2025.
//

import SwiftUI

struct MarsPhotoDetailView: View {
    let photo: MarsPhoto

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // add image
                
                Text("Camera: \(photo.camera.fullName)")
                    .font(.headline)

                Text("Rover: \(photo.rover.name)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Date: \(photo.earthDate)")
                    .font(.caption)
                    .foregroundColor(.gray)

               // add actions buttons
            }
            .padding()
        }
        .navigationTitle("Mars Photo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
