//
//  CosmoCuriosityAppTests.swift
//  CosmoCuriosityAppTests
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import Testing
import XCTest
@testable import CosmoCuriosityApp

class CosmoCuriosityApp: XCTestCase {
    func testFetchInitialAPODs() {
        APODViewModelTests().testFetchInitialAPODs()
    }
    
    func testLoadNextPageAppendsData() {
        APODViewModelTests().testLoadNextPageAppendsData()
    }
    
    func testLoadPhotosLoadsCorrectly() {
        MarsPhotosViewModelTests().testLoadPhotosLoadsCorrectly()
    }
    
    func testLoadPhotosSuccess() {
        MarsPhotosViewModelTests().testLoadPhotosSuccess()
    }
    
    func testLoadPhotosFailure() {
        MarsPhotosViewModelTests().testLoadPhotosFailure()
    }
    
    func testLoadImagesReturnsEPICImages() {
        EPICViewModelTests().testLoadImagesReturnsEPICImages()
    }
    
    func testSearchReturnsResults() {
        ImageSearchViewModelTests().testSearchReturnsResults()
    }
    
    func testSearchImagesSuccess() {
        ImageSearchViewModelTests().testSearchImagesSuccess()
    }
    
    func testSearchImagesFailure() {
        ImageSearchViewModelTests().testSearchImagesFailure()
    }
}

class APODViewModelTests: XCTestCase {
    func testFetchInitialAPODs() {
        let mockAPOD = APOD(
            title: "Test Title",
            explanation: "Test Explanation",
            url: "https://example.com/image.jpg",
            mediaType: "image"
        )
        
        let mockService = MockNasaService()
        mockService.mockAPODs = [mockAPOD]

        let viewModel = APODViewModel(service: mockService)
        viewModel.apods = []
        viewModel.loadNextPage()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.apods.count, 1)
            XCTAssertEqual(viewModel.apods.first?.title, "Test Title")
        }
    }

    func testLoadNextPageAppendsData() {
        let mockAPOD = APOD(
            title: "Test Title",
            explanation: "Test Explanation",
            url: "https://example.com/image.jpg",
            mediaType: "image"
        )
        
        let mockService = MockNasaService()
        mockService.mockAPODs = [mockAPOD]
        let viewModel = APODViewModel(service: mockService)
        viewModel.loadNextPage()
        
        let expectation = XCTestExpectation(description: "Next page loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(viewModel.apods.count, 2)
            XCTAssertEqual(viewModel.apods.first?.title, "Test Title")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

class MarsPhotosViewModelTests: XCTestCase {
    func testLoadPhotosLoadsCorrectly() {
        let mockPhoto = MarsPhoto(
            photoId: 1,
            imgSrc: "https://example.com/mars.jpg",
            earthDate: "2024-12-30",
            camera: .init(name: "Curiosity", fullName: "Mast Camera"),
            rover: .init(name: "Curiosity", landingDate: "2024-12-30", launchDate: "2024-12-30")
        )
        
        let mockService = MockNasaService()
        mockService.mockMarsPhotos = [mockPhoto]
        
        let viewModel = MarsPhotosViewModel(service: mockService)
        viewModel.loadPhotos(for: "2024-12-30")
        
        XCTAssertEqual(viewModel.photos.count, 1)
        XCTAssertEqual(viewModel.photos.first?.camera.fullName, "Mast Camera")
    }
    
    func testLoadPhotosSuccess()  {
        let mockPhoto = MarsPhoto(
            photoId: 1,
            imgSrc: "https://example.com/mars.jpg",
            earthDate: "2024-12-30",
            camera: .init(name: "Curiosity", fullName: "Mast Camera"),
            rover: .init(name: "Curiosity", landingDate: "2024-12-30", launchDate: "2024-12-30")
        )
        
        let mockService = MockNasaService()
        mockService.mockMarsPhotos = [mockPhoto]
        
        let viewModel = MarsPhotosViewModel(service: mockService)
        viewModel.loadPhotos(for: "2024-12-30")
        
        let expectation = XCTestExpectation(description: "photos sucess")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(viewModel.photos.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadPhotosFailure()  {
        let mockService = MockNasaService()
        let viewModel = MarsPhotosViewModel(service: mockService)
        mockService.shouldFail = true
        viewModel.loadPhotos(for: "2024-12-30")
        
        let expectation = XCTestExpectation(description: "photos failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(viewModel.photos.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

class EPICViewModelTests: XCTestCase {
    func testLoadImagesReturnsEPICImages() {
        let mockImage = EPICImage(
            identifier: "1",
            caption: "Earth from space",
            image: "2024-12-30",
            date: "https://example.com/epic.jpg"
        )

        let mockService = MockNasaService()
        mockService.mockEPICImages = [mockImage]

        let viewModel = EPICViewModel(service: mockService)
        viewModel.loadImages()

        XCTAssertEqual(viewModel.images.count, 1)
        XCTAssertEqual(viewModel.images.first?.caption, "Earth from space")
    }
}

class ImageSearchViewModelTests: XCTestCase {
    func testSearchReturnsResults() {
        let mockItem = NasaImage(
            id: "1",
            title: "Test Image",
            description: "Test Description",
            thumbnailURL: "https://example.com/thumb.jpg", fullImageURL: ""
        )

        let mockService = MockNasaService()
        mockService.mockSearchImages = [mockItem]

        let viewModel = ImageSearchViewModel(service: mockService)
        viewModel.search("moon")

        XCTAssertEqual(viewModel.results.count, 1)
        XCTAssertEqual(viewModel.results.first?.title, "Test Image")
    }
    
    func testSearchImagesSuccess() {
        let mockItem = NasaImage(
            id: "1",
            title: "Test Image",
            description: "Test Description",
            thumbnailURL: "https://example.com/thumb.jpg", fullImageURL: ""
        )
        
        let mockService = MockNasaService()
        mockService.mockSearchImages = [mockItem]
        let viewModel = ImageSearchViewModel(service: mockService)
        viewModel.search("moon")
        
        let expectation = XCTestExpectation(description: "search success")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(viewModel.results.count, 1)
            XCTAssertEqual(viewModel.results.first?.title, "Test Image")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchImagesFailure() {
        let mockService = MockNasaService()
        mockService.mockSearchImages = []
        mockService.shouldFail = true
        let viewModel = ImageSearchViewModel(service: mockService)
        viewModel.search("moon")
        
        let expectation = XCTestExpectation(description: "search failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.results.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
