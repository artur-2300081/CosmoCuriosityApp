//
//  EPICDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 14/05/2025.
//

import SwiftUI

struct EPICDetailView: View {
    let image: EPICImage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: URL(string: image.imageURL))
                
                Text(image.caption)
                    .font(.title2)

                Text("Date: \(image.date)")
                    .font(.caption)
                    .foregroundColor(.gray)

                // add action buttons
            }
            .padding()
        }
        .navigationTitle("Earth Image")
        .navigationBarTitleDisplayMode(.inline)
    }
}
