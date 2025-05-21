//
//  APODView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct APODView: View {
    @StateObject private var viewModel: APODViewModel
    @EnvironmentObject var apodFavorites: APODFavorites

    init(viewModel: APODViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.apods.indices, id: \.self) { index in
                        let apod = viewModel.apods[index]

                        VStack(alignment: .leading, spacing: 12) {
                            NavigationLink(destination: APODDetailView(apod: apod)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    AsyncImageView(url: URL(string: apod.url))

                                    Text(apod.title)
                                        .font(.headline)

                                    Text(apod.explanation)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(5)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()

                            ActionButtonsView(
                                item: apod,
                                isFavorite: apodFavorites.isFavorite,
                                toggleFavorite: apodFavorites.toggle,
                                share: { _ in SharingHelper.share(url: URL(string: apod.url)!) }
                            )
                        }
                        .cardViewStyle()

                        if index == viewModel.apods.count - 1 {
                            ProgressView()
                                .onAppear {
                                    viewModel.loadNextPage()
                                }
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Picture of the day")
        }
    }
}

