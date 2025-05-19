//
//  ImageSearchView.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import SwiftUI

struct ImageSearchView: View {
    @StateObject private var viewModel: ImageSearchViewModel
    @State private var query = ""
    
    init(viewModel: ImageSearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search NASA images...", text: $query, onCommit: {
                        viewModel.search(query)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding(.trailing)
                    }
                }
                .padding(.vertical, 10)
                .background(Color(UIColor.systemBackground))
                .zIndex(1)
                
                if viewModel.results.isEmpty && !query.isEmpty {
                    Text("No results found.")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.results) { item in
                                VStack(alignment: .leading, spacing: 12) {
                                    NavigationLink(destination: ImageSearchDetailView(item: item)) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            // add image
                                            
                                            Text(item.title)
                                                .font(.headline)
                                            
                                            if let desc = item.description {
                                                Text(desc)
                                                    .font(.caption)
                                                    .lineLimit(2)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    // add action buttons
                                    
                                    Divider()
                                }
                                .cardViewStyle()
                            }
                        }
                    }
                }
            }
            .navigationTitle("NASA Search")
        }
    }
}

