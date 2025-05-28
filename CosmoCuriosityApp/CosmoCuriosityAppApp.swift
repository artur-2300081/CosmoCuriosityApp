//
//  CosmoCuriosityAppApp.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

@main
struct CosmoCuriosityApp: App {
    @StateObject var apodFavorites = APODFavorites()
    @StateObject var marsFavorites = MarsFavorites()
    @StateObject var searchFavorites = ImageSearchFavorites()
    @StateObject var epicFavorites = EPICFavorites()
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainTabView(
                    apodFavorites: apodFavorites,
                    marsFavorites: marsFavorites,
                    searchFavorites: searchFavorites,
                    epicFavorites: epicFavorites
                )
                
                if showSplash {
                    SplashView()
                        .autoDismissSplash(isVisible: $showSplash)
                }
            }
        }
    }
}
