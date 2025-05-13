//
//  APODView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct APODView: View {
    @StateObject private var viewModel: APODViewModel

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
                                    // add image view

                                    Text(apod.title)
                                        .font(.headline)

                                    Text(apod.explanation)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(5)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            // add action buttons

                            Divider()
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

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

