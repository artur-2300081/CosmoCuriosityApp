//
//  EPICView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct EPICView: View {
    @EnvironmentObject var epicFavorites: EPICFavorites
    @StateObject private var viewModel: EPICViewModel
    
    init(viewModel: EPICViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.images) { image in
                        VStack(alignment: .leading, spacing: 12) {
                            NavigationLink(destination: EPICDetailView(image: image)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    AsyncImageView(url: URL(string: image.imageURL))
                                    
                                    Text(image.caption)
                                        .font(.subheadline)

                                    Text("Date: \(image.date)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()

                            ActionButtonsView(
                                item: image,
                                isFavorite: epicFavorites.isFavorite,
                                toggleFavorite: epicFavorites.toggle,
                                share: { _ in SharingHelper.share(url: URL(string: image.imageURL)!) }
                            )
                        }
                        .cardViewStyle()
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Earth View")
            .onAppear {
                viewModel.loadImages()
            }
        }
    }
}
