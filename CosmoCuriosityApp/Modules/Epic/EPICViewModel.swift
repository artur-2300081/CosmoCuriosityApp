//
//  EPICViewModel.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 14/05/2025.
//

import Foundation

/// ViewModel responsible for managing EPIC (Earth Polychromatic Imaging Camera) image data.
///
/// Fetches and provides EPIC images for the view.
class EPICViewModel: ObservableObject {
    /// EPIC images.
    @Published var images: [EPICImage] = []
    
    
    private let service: NasaServiceProtocol
    
    init(service: NasaServiceProtocol) {
        self.service = service
    }

    /// Loads EPIC images.
    func loadImages() {
        service.fetchEPICImages { [weak self] result in
            self?.images = result
        }
    }
}
