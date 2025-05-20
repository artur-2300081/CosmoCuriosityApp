//
//  APODDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 12/05/2025.
//

import SwiftUI

struct APODDetailView: View {
    let apod: APOD

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: URL(string: apod.url))
                
                // add action buttons
                Text(apod.title)
                    .font(.title2)

                Text(apod.explanation)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
