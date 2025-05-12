//
//  NasaServiceProtocol.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

/// Protocol responsible for communicating with the NASA public APIs.
///
/// Provides methods to fetch APOD data, Mars Rover photos, EPIC images, and perform image searches.
protocol NasaServiceProtocol {
    /// Fetches the list of Astronomy Picture of the Day (APOD) items.
    ///
    /// - Returns: An array of `APOD` items.
    func fetchAPOD(startDate: Date, endDate: Date, completion: @escaping ([APOD]) -> Void)
    
    /// Fetches Mars Rover photos for a specific Earth date.
    ///
    /// - Parameter date: The Earth date in `YYYY-MM-DD` format.
    /// - Returns: An array of `MarsPhoto` items.
    func fetchMarsPhotos(for date: String, completion: @escaping ([MarsPhoto]) -> Void)
    
    /// Fetches EPIC Earth images.
    ///
    /// - Returns: An array of `EPICImage` items.
    func fetchEPICImages(completion: @escaping ([EPICImage]) -> Void)
    
    /// Searches the NASA Image and Video Library.
    ///
    /// - Parameter query: Search keyword.
    /// - Returns: An array of `NasaImage` items.
    func searchImages(query: String, page: Int, completion: @escaping ([NasaImage]) -> Void)
}
