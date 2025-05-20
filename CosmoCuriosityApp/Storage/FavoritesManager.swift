//
//  FavoritesManager.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

import Foundation

class FavoritesManager<T: Codable & Identifiable & Equatable>: ObservableObject {
    @Published private(set) var items: [T] = []
    private let storageKey: String
    private let cloudAvailable: Bool
    private let useCloud: Bool
    
    init(storageKey: String, preferCloud: Bool = true) {
        self.storageKey = storageKey
        self.cloudAvailable = FileManager.default.ubiquityIdentityToken != nil
        self.useCloud = preferCloud && cloudAvailable
        
        load()
        
        if useCloud {
            NotificationCenter.default.addObserver(
                forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                object: NSUbiquitousKeyValueStore.default,
                queue: .main
            ) { [weak self] _ in
                self?.load()
            }
        }
    }
    
    func toggle(_ item: T) {
        if isFavorite(item) {
            items.removeAll { $0.id == item.id }
        } else {
            items.append(item)
        }
        save()
    }
    
    func isFavorite(_ item: T) -> Bool {
        items.contains { $0.id == item.id }
    }
    
    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        
        if useCloud {
            NSUbiquitousKeyValueStore.default.set(data, forKey: storageKey)
            NSUbiquitousKeyValueStore.default.synchronize()
        } else {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func load() {
        let data: Data?
        
        if useCloud {
            data = NSUbiquitousKeyValueStore.default.data(forKey: storageKey)
        } else {
            data = UserDefaults.standard.data(forKey: storageKey)
        }
        
        if let data, let decoded = try? JSONDecoder().decode([T].self, from: data) {
            self.items = decoded
        } else {
            self.items = []
        }
    }
}
