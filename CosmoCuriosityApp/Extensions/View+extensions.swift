//
//  View+extensions.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 19/05/2025.
//

import SwiftUI

extension View {
    func cardViewStyle() -> some View {
        modifier(CardViewStyle())
    }
}

extension View {
    func autoDismissSplash(isVisible: Binding<Bool>, after duration: TimeInterval = 2.0) -> some View {
        modifier(AutoDismissSplashModifier(isVisible: isVisible, duration: duration))
    }
}
