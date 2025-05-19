//
//  ActionButtonsView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 19/05/2025.
//

import SwiftUI

struct ActionButtonsView<T: Identifiable & Equatable>: View {
    let item: T
    let isFavorite: (T) -> Bool
    let toggleFavorite: (T) -> Void
    let share: (T) -> Void

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                toggleFavorite(item)
            }) {
                Image(systemName: isFavorite(item) ? "heart.fill" : "heart")
            }
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("FavoriteButton")

            Button(action: {
                share(item)
            }) {
                Image(systemName: "square.and.arrow.up")
            }
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("ShareButton")
        }
        .padding(.vertical, 8)
        .font(.title3)
    }
}
