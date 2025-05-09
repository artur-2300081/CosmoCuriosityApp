//
//  APOD.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

struct APOD: Decodable, Identifiable, Equatable, Encodable {
    var id: String { url }
    let title: String
    let explanation: String
    let url: String
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case title, explanation, url, mediaType = "media_type"
    }
}

