//
//  APODFavorites.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

final class APODFavorites: FavoritesManager<APOD> {
    init() {
        super.init(storageKey: "favorite_apods")
    }
}
