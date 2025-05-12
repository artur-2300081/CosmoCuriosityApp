//
//  NasaImage.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

/// Represents the full response structure returned by the NASA Image and Video Library search API.
struct NasaImageSearchResponse: Decodable {
    /// Contains the search result collection, including image items.
    struct Collection: Decodable {
        /// The list of image or video items returned by the query.
        let items: [Item]
    }

    /// Represents an individual item in the search result.
    struct Item: Decodable {
        /// Metadata array describing the item (title, description, etc.).
        let data: [Metadata]
        
        /// Optional list of associated links (e.g., thumbnails or full-size images).
        let links: [Link]?
    }

    /// Metadata associated with a media item in the NASA library.
    struct Metadata: Decodable {
        /// The title of the image or video.
        let title: String
        
        /// Optional description of the media item.
        let description: String?
        
        /// The unique NASA ID used to reference the item.
        let nasaID: String

        enum CodingKeys: String, CodingKey {
            case title, description
            case nasaID = "nasa_id"
        }
    }

    /// Link to a media resource (e.g., thumbnail or image).
    struct Link: Decodable {
        /// The URL to the media resource.
        let href: String
        
        /// Optional type of relation (e.g., "preview").
        let rel: String?
    }

    /// The main search result collection.
    let collection: Collection
}

/// Represents a NASA Image or Video item from the Image and Video Library API.
///
/// Includes title, description, thumbnail URL, and full image URL.
struct NasaImage: Identifiable, Encodable, Equatable, Decodable {
    /// Unique identifier.
    let id: String
    
    /// Title of the item.
    let title: String
    
    /// Description or summary.
    let description: String?
    
    /// URL of the thumbnail image.
    let thumbnailURL: String
    
    /// URL of the full-size image.
    let fullImageURL: String
}
