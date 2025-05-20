//
//  ImageSearchFavorites.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

final class ImageSearchFavorites: FavoritesManager<NasaImage> {
    init() {
        super.init(storageKey: "favorite_search")
    }
}
