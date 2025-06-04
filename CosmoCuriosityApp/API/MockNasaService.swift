//
//  MockNasaService.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 02/06/2025.
//

import Foundation

class MockNasaService: NasaServiceProtocol {
    var mockAPODs: [APOD] = []
    var mockMarsPhotos: [MarsPhoto] = []
    var mockEPICImages: [EPICImage] = []
    var mockSearchImages: [NasaImage] = []
    var shouldFail = false
    
    func fetchAPOD(startDate: Date, endDate: Date, completion: @escaping ([APOD]) -> Void) {
        completion(mockAPODs)
    }
    
    func fetchMarsPhotos(for date: String, completion: @escaping ([MarsPhoto]) -> Void) {
        completion(mockMarsPhotos)
    }
    
    func fetchEPICImages(completion: @escaping ([EPICImage]) -> Void) {
        completion(mockEPICImages)
    }
    
    func searchImages(query: String, page: Int, completion: @escaping ([NasaImage]) -> Void) {
        completion(mockSearchImages)
    }

    func fetchAPOD(startDate: Date?, endDate: Date?) async throws -> [APOD] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockAPODs
    }
    
    func fetchMarsPhotos(for date: Date) async throws -> [MarsPhoto] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockMarsPhotos
    }
    
    func searchImages(query: String) async throws -> [NasaImage] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return mockSearchImages
    }
}
