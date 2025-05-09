//
//  NasaService.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 09/05/2025.
//

import Foundation

class NasaService: NasaServiceProtocol {
    private let apiKey = "cN3aqTvVXDJfMYWwjR4gLK0hQXWznsq2dbZcIJrz"
}

// MARK: fetchAPOD
extension NasaService {
    func fetchAPOD(startDate: Date, endDate: Date, completion: @escaping ([APOD]) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let startStr = formatter.string(from: startDate)
        let endStr = formatter.string(from: endDate)
        
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&start_date=\(startStr)&end_date=\(endStr)&thumbs=true"
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let apods = try? JSONDecoder().decode([APOD].self, from: data) else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            DispatchQueue.main.async {
                completion(apods.reversed())
            }
        }.resume()
    }
}

// MARK: - fetchMarsPhotos
extension NasaService {
    func fetchMarsPhotos(for date: String, completion: @escaping ([MarsPhoto]) -> Void) {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(date)&api_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let result = try? JSONDecoder().decode(MarsPhotoResponse.self, from: data) else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            DispatchQueue.main.async {
                completion(result.photos)
            }
        }.resume()
    }
}

// MARK: - searchImages
extension NasaService {
    func searchImages(query: String, page: Int = 1, completion: @escaping ([NasaImage]) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://images-api.nasa.gov/search?q=\(encodedQuery)&media_type=image&page=\(page)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let response = try? JSONDecoder().decode(NasaImageSearchResponse.self, from: data) else {
                DispatchQueue.main.async { completion([]) }
                return
            }

            let items = response.collection.items.compactMap { item -> NasaImage? in
                guard let data = item.data.first,
                      let link = item.links?.first(where: { $0.rel == nil || $0.rel == "preview" }) else {
                    return nil
                }

                return NasaImage(
                    id: data.nasaID,
                    title: data.title,
                    description: data.description,
                    thumbnailURL: link.href,
                    fullImageURL: link.href
                )
            }

            DispatchQueue.main.async {
                completion(items)
            }
        }.resume()
    }
}

// MARK: - fetchEPICImages
extension NasaService {
    func fetchEPICImages(completion: @escaping ([EPICImage]) -> Void) {
        let urlString = "https://api.nasa.gov/EPIC/api/natural?api_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let images = try? JSONDecoder().decode([EPICImage].self, from: data) else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            DispatchQueue.main.async {
                completion(images)
            }
        }.resume()
    }
}
