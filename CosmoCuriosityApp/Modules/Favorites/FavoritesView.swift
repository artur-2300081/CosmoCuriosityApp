//
//  FavoritesView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 21/05/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var apodFavorites: APODFavorites
    @EnvironmentObject var marsFavorites: MarsFavorites
    @EnvironmentObject var searchFavorites: ImageSearchFavorites
    @EnvironmentObject var epicFavorites: EPICFavorites

    var body: some View {
        NavigationView {
            List {
                if !apodFavorites.items.isEmpty {
                    Section(header: Text("APOD")) {
                        ForEach(apodFavorites.items) { apod in
                            NavigationLink(destination: APODDetailView(apod: apod)) {
                                Text(apod.title)
                            }
                        }
                    }
                }

                if !marsFavorites.items.isEmpty {
                    Section(header: Text("Mars")) {
                        ForEach(marsFavorites.items) { photo in
                            NavigationLink(destination: MarsPhotoDetailView(photo: photo)) {
                                Text(photo.camera.fullName)
                            }
                        }
                    }
                }
                
                if !epicFavorites.items.isEmpty {
                    Section(header: Text("Epic")) {
                        ForEach(epicFavorites.items) { image in
                            NavigationLink(destination: EPICDetailView(image: image)) {
                                Text(image.caption)
                            }
                        }
                    }
                }

                if !searchFavorites.items.isEmpty {
                    Section(header: Text("Search Images")) {
                        ForEach(searchFavorites.items) { item in
                            NavigationLink(destination: ImageSearchDetailView(item: item)) {
                                Text(item.title)
                            }
                        }
                    }
                }

                if apodFavorites.items.isEmpty &&
                    marsFavorites.items.isEmpty &&
                    epicFavorites.items.isEmpty &&
                    searchFavorites.items.isEmpty {
                    Text("No favorites yet!").foregroundColor(.gray)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
