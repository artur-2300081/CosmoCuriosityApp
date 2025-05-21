//
//  MainTabView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct MainTabView: View {
    let apodFavorites: APODFavorites
    let marsFavorites: MarsFavorites
    let searchFavorites: ImageSearchFavorites
    let epicFavorites: EPICFavorites
    
    var body: some View {
        TabView {
            APODView(viewModel: APODViewModel(service: NasaService()))
                .environmentObject(apodFavorites)
                .tabItem {
                    Label(String(localized: "tab_home"), systemImage: "house")
                }
            MarsPhotosView(viewModel: MarsPhotosViewModel(service: NasaService()))
                .environmentObject(marsFavorites)
                .tabItem {
                    Label(String(localized: "tab_mars"), systemImage: "circle.fill")
                }
            EPICView(viewModel: EPICViewModel(service: NasaService()))
                .environmentObject(epicFavorites)
                .tabItem {
                    Label(String(localized: "tab_earth"), systemImage: "globe.americas")
                }
            ImageSearchView(viewModel: ImageSearchViewModel(service: NasaService()))
                .environmentObject(searchFavorites)
                .tabItem {
                    Label(String(localized: "tab_search"), systemImage: "magnifyingglass")
                }
            FavoritesView()
                .environmentObject(apodFavorites)
                .environmentObject(marsFavorites)
                .environmentObject(searchFavorites)
                .environmentObject(epicFavorites)
                .tabItem {
                    Label(String(localized: "tab_favorites"), systemImage: "star.fill")
                }
        }
    }
}

