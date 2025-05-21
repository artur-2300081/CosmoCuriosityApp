//
//  MarsPhotosView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct MarsPhotosView: View {
    @EnvironmentObject var marsFavorites: MarsFavorites
    @StateObject private var viewModel: MarsPhotosViewModel
    @State private var selectedDate = Date()
    
    init(viewModel: MarsPhotosViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Earth Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .onChange(of: selectedDate) { _, newDate in
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        viewModel.loadPhotos(for: formatter.string(from: newDate))
                    }

                if viewModel.photos.isEmpty {
                    Text("No photos found for this date.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.photos) { photo in
                                VStack(alignment: .leading, spacing: 12) {
                                    NavigationLink(destination: MarsPhotoDetailView(photo: photo)) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            AsyncImageView(url: URL(string: photo.imgSrc))

                                            Text("Camera: \(photo.camera.fullName)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Divider()

                                    ActionButtonsView(
                                        item: photo,
                                        isFavorite: marsFavorites.isFavorite,
                                        toggleFavorite: marsFavorites.toggle,
                                        share: { _ in SharingHelper.share(url: URL(string: photo.imgSrc)!) }
                                    )                                    
                                }
                                .cardViewStyle()
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Mars Rover")
            .onAppear {
                if viewModel.photos.isEmpty {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    viewModel.loadPhotos(for: formatter.string(from: selectedDate))
                }
            }
        }
    }
}
