//
//  SplashView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 27/05/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 222 / 255, green: 165 / 255, blue: 62 / 255).ignoresSafeArea()
            Image("Splash")
                .resizable()
                .scaledToFit()
                .frame(width: 180)
        }
    }
}
