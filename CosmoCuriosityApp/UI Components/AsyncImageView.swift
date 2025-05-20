//
//  AsyncImageView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    var cornerRadius: CGFloat = 12

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity)
        }
        .cornerRadius(cornerRadius)
    }
}
