//
//  MarsPhotosViewModel.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 13/05/2025.
//

import Foundation

/// ViewModel responsible for managing Mars Rover photo data.
///
/// Loads photos for a given Earth date and handles user interactions.
class MarsPhotosViewModel: ObservableObject {
    /// The loaded Mars Rover photos.
    @Published var photos: [MarsPhoto] = []
    
    /// NasaService.
    private let service: NasaServiceProtocol
    
    init(service: NasaServiceProtocol) {
        self.service = service
    }

    /// Loads Mars photos for the specified Earth date.
    ///
    /// - Parameter date: The Earth date in `YYYY-MM-DD` format.
    func loadPhotos(for date: String) {
        service.fetchMarsPhotos(for: date) { [weak self] newPhotos in
            self?.photos = newPhotos
        }
    }
}
