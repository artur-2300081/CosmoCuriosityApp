//
//  APODViewModel.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 12/05/2025.
//

import SwiftUI

/// ViewModel responsible for managing APOD (Astronomy Picture of the Day) data.
///
/// Handles pagination, data fetching, and user interactions like sharing.
class APODViewModel: ObservableObject {
    /// APOD items.
    @Published var apods: [APOD] = []
    
    /// NasaService.
    private let service: NasaServiceProtocol
    
    /// Initial end date.
    private var currentEndDate = Date()
    
    /// Number of pages at a time.
    private let pageSize = 1

    init(service: NasaServiceProtocol) {
        self.service = service
        loadNextPage()
    }
}

extension APODViewModel {
    /// Fetches the next page of APOD data.
    func loadNextPage() {
        let calendar = Calendar.current
        guard let newStartDate = calendar.date(byAdding: .day, value: -pageSize + 1, to: currentEndDate) else { return }

        service.fetchAPOD(startDate: newStartDate, endDate: currentEndDate) { [weak self] newItems in
            self?.apods.append(contentsOf: newItems)
            self?.currentEndDate = calendar.date(byAdding: .day, value: -(self?.pageSize ?? 1), to: self!.currentEndDate)!
        }
    }
    
    /// Shares the selected APOD item.
    ///
    /// - Parameter apod: The APOD item to share.
    func shareAPOD(_ apod: APOD) {
        // implement
    }
}
