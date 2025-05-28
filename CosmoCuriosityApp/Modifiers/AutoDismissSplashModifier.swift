//
//  AutoDismissSplashModifier.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 27/05/2025.
//

import SwiftUI

struct AutoDismissSplashModifier: ViewModifier {
    @Binding var isVisible: Bool
    let duration: TimeInterval

    func body(content: Content) -> some View {
        content
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        isVisible = false
                    }
                }
            }
    }
}
