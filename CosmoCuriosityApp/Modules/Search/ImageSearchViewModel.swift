//
//  ImageSearchViewModel.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 15/05/2025.
//

import Foundation

/// ViewModel responsible for managing NASA Image and Video Library search.
///
/// Performs search queries and handles the resulting items.
class ImageSearchViewModel: ObservableObject {
    /// The search results of NasaImage objects.
    @Published var results: [NasaImage] = []
    
    /// Indicates if search is in progress.
    @Published var isLoading = false

    /// NasaService.
    private let service: NasaServiceProtocol
    
    init(service: NasaServiceProtocol) {
        self.service = service
    }

    /// Executes a search query.
    ///
    /// - Parameter query: String
    func search(_ query: String) {
        isLoading = true
        service.searchImages(query: query, page: 1) { [weak self] images in
            self?.results = images
            self?.isLoading = false
        }
    }
}
