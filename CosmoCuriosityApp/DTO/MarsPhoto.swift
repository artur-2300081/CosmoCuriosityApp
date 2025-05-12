//
//  MarsPhoto.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

/// Represents array of MarsPhoto elements
struct MarsPhotoResponse: Decodable {
    let photos: [MarsPhoto]
}

/// Represents a photo taken by the Mars Rover.
///
/// Contains information such as the image URL, Earth date, camera details, and rover metadata.
struct MarsPhoto: Decodable, Identifiable, Equatable, Encodable {
    /// Unique identifier for the photo.
    var id: String { String(photoId) }
    let photoId: Int
    
    /// Image URL.
    let imgSrc: String
    
    /// Earth date when the photo was taken.
    let earthDate: String
    
    /// Camera details.
    let camera: Camera
    
    /// Rover details.
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case camera, rover
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case photoId = "id"
    }

    /// Represents the camera used by a Mars Rover to capture a photo.
    ///
    /// Includes short and full names of the camera.
    struct Camera: Decodable, Identifiable, Equatable, Encodable {
        /// Unique identifier composed of the camera's name and full name.
        var id: String { name + fullName }
        
        /// Short code name of the camera
        let name: String
        
        /// Full descriptive name of the camera
        let fullName: String

        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
        }
    }

    /// Represents metadata about the Mars Rover that captured a photo.
    ///
    /// Includes the rover's name, landing date, and launch date.
    struct Rover: Decodable, Identifiable, Equatable, Encodable {
        /// Unique identifier composed of name, landing date, and launch date.
        var id: String { name + landingDate +  launchDate }
        
        /// Name of the Mars Rover
        let name: String
        
        /// The date when the rover landed on Mars (in `YYYY-MM-DD` format).
        let landingDate: String
        
        /// The date when the rover was launched from Earth (in `YYYY-MM-DD` format).
        let launchDate: String

        enum CodingKeys: String, CodingKey {
            case name
            case landingDate = "landing_date"
            case launchDate = "launch_date"
        }
    }
}
