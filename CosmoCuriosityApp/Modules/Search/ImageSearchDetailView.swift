//
//  ImageSearchDetailView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 15/05/2025.
//

import SwiftUI

struct ImageSearchDetailView: View {
    let item: NasaImage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // add image
                
                Text(item.title)
                    .font(.title2)

                if let desc = item.description {
                    Text(desc)
                        .font(.body)
                }

               // add action buttons
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
