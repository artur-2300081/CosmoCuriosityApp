//
//  NasaServiceProtocol.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

protocol NasaServiceProtocol {
    func fetchAPOD(startDate: Date, endDate: Date, completion: @escaping ([APOD]) -> Void)
    func fetchMarsPhotos(for date: String, completion: @escaping ([MarsPhoto]) -> Void)
    func searchImages(query: String, page: Int, completion: @escaping ([NasaImage]) -> Void)
    func fetchEPICImages(completion: @escaping ([EPICImage]) -> Void)
}
