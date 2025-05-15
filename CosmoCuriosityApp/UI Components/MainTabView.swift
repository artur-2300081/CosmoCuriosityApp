//
//  MainTabView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            APODView(viewModel: APODViewModel(service: NasaService()))
            .tabItem {
                Label(String(localized: "tab_home"), systemImage: "house")
            }
            MarsPhotosView(viewModel: MarsPhotosViewModel(service: NasaService()))
            .tabItem {
                Label(String(localized: "tab_mars"), systemImage: "circle.fill")
            }
            EPICView(viewModel: EPICViewModel(service: NasaService()))
            .tabItem {
                Label(String(localized: "tab_earth"), systemImage: "globe.americas")
            }
            ImageSearchView(viewModel: ImageSearchViewModel(service: NasaService()))
            .tabItem {
                Label(String(localized: "tab_search"), systemImage: "magnifyingglass")
            }
        }
    }
}

