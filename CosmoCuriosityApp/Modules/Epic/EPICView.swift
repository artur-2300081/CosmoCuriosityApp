//
//  EPICView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct EPICView: View {
    @StateObject private var viewModel: EPICViewModel
    
    init(viewModel: EPICViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.images) { image in
                        VStack(alignment: .leading, spacing: 12) {
                            NavigationLink(destination: EPICDetailView(image: image)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    // add image
                                    
                                    Text(image.caption)
                                        .font(.subheadline)

                                    Text("Date: \(image.date)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            // add actions button
                            
                            Divider()
                        }
                        .cardViewStyle()
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Earth View")
            .onAppear {
                viewModel.loadImages()
            }
        }
    }
}
