//
//  EPICFavorites.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

final class EPICFavorites: FavoritesManager<EPICImage> {
    init() {
        super.init(storageKey: "epic_favorites")
    }
}
