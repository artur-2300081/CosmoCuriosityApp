//
//  APOD.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

/// Represents the Astronomy Picture of the Day (APOD) model.
///
/// This model contains the data returned by the NASA APOD API, including title, explanation, media type, and media URL.
struct APOD: Decodable, Identifiable, Equatable, Encodable {
    /// Unique identifier for the APOD item.
    var id: String { url }
    
    /// Title of the image or video.
    let title: String
    
    /// Scientific explanation or description.
    let explanation: String
    
    /// URL pointing to the image or video.
    let url: String
    
    /// Type of media, such as "image" or "video".
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case title, explanation, url, mediaType = "media_type"
    }
}

