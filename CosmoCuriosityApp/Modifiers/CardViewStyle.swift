//
//  CardViewStyle.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 19/05/2025.
//

import SwiftUI

struct CardViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            .padding(.horizontal)
    }
}
