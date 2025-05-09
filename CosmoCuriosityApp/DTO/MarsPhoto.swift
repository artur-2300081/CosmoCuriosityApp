//
//  MarsPhoto.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

struct MarsPhotoResponse: Decodable {
    let photos: [MarsPhoto]
}

struct MarsPhoto: Decodable, Identifiable, Equatable, Encodable {
    var id: String { String(photoId) }
    let photoId: Int
    let imgSrc: String
    let earthDate: String
    let camera: Camera
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case camera, rover
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case photoId = "id"
    }

    struct Camera: Decodable, Identifiable, Equatable, Encodable {
        var id: String { name + fullName }
        let name: String
        let fullName: String

        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
        }
    }

    struct Rover: Decodable, Identifiable, Equatable, Encodable {
        var id: String { name + landingDate +  launchDate }
        let name: String
        let landingDate: String
        let launchDate: String

        enum CodingKeys: String, CodingKey {
            case name
            case landingDate = "landing_date"
            case launchDate = "launch_date"
        }
    }
}
