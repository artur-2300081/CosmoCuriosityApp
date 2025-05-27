//
//  CardViewStyle.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 19/05/2025.
//

import SwiftUI

struct CardViewStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: colorScheme == .light ? Color.black.opacity(0.05) : Color.white.opacity(0.2), radius: 4, x: 0, y: 2)
            .padding(.horizontal)
    }
}
