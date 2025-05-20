//
//  MarsFavorites.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

final class MarsFavorites: FavoritesManager<MarsPhoto> {
    init() {
        super.init(storageKey: "favorite_mars")
    }
}
