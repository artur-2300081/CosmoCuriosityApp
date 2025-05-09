//
//  EPICImage.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

struct EPICImage: Decodable, Identifiable, Equatable, Encodable {
    let identifier: String
    let caption: String
    let image: String
    let date: String
    var id: String { identifier }
    var formattedDateComponents: (year: String, month: String, day: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: self.date) {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
            return (
                String(format: "%04d", components.year ?? 0),
                String(format: "%02d", components.month ?? 0),
                String(format: "%02d", components.day ?? 0)
            )
        }
        return ("0000", "00", "00")
    }
    var imageURL: String {
        let (y, m, d) = formattedDateComponents
        return "https://epic.gsfc.nasa.gov/archive/natural/\(y)/\(m)/\(d)/png/\(image).png"
    }
}
