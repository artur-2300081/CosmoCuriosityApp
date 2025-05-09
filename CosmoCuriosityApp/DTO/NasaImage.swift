//
//  NasaImage.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

struct NasaImageSearchResponse: Decodable {
    struct Collection: Decodable {
        let items: [Item]
    }

    struct Item: Decodable {
        let data: [Metadata]
        let links: [Link]?
    }

    struct Metadata: Decodable {
        let title: String
        let description: String?
        let nasaID: String

        enum CodingKeys: String, CodingKey {
            case title, description
            case nasaID = "nasa_id"
        }
    }

    struct Link: Decodable {
        let href: String
        let rel: String?
    }

    let collection: Collection
}

struct NasaImage: Identifiable, Encodable, Equatable, Decodable {
    let id: String
    let title: String
    let description: String?
    let thumbnailURL: String
    let fullImageURL: String
}
