//
//  MainTabView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

/// The root tab bar navigation view of the application.
/// Displays main sections: APOD, Mars, EPIC, Image Search, and Favorites.
struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let apodFavorites: APODFavorites
    let marsFavorites: MarsFavorites
    let searchFavorites: ImageSearchFavorites
    let epicFavorites: EPICFavorites
    
    var body: some View {
        TabView {
            APODView(viewModel: APODViewModel(service: NasaService()))
                .environmentObject(apodFavorites)
                .tabItem {
                    Label(String(localized: "Home"), systemImage: "photo.stack")
                }
            MarsPhotosView(viewModel: MarsPhotosViewModel(service: NasaService()))
                .environmentObject(marsFavorites)
                .tabItem {
                    Label(String(localized: "Mars"), systemImage: "m.circle")
                }
            EPICView(viewModel: EPICViewModel(service: NasaService()))
                .environmentObject(epicFavorites)
                .tabItem {
                    Label(String(localized: "Earth"), systemImage: "globe.americas")
                }
            ImageSearchView(viewModel: ImageSearchViewModel(service: NasaService()))
                .environmentObject(searchFavorites)
                .tabItem {
                    Label(String(localized: "Search"), systemImage: "magnifyingglass")
                }
            FavoritesView()
                .environmentObject(apodFavorites)
                .environmentObject(marsFavorites)
                .environmentObject(searchFavorites)
                .environmentObject(epicFavorites)
                .tabItem {
                    Label(String(localized: "Favorites"), systemImage: "star.fill")
                }
        }
        .accentColor(colorScheme == .light ? Color.black : Color.white)
    }
}

