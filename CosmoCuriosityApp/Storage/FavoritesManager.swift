//
//  FavoritesManager.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 20/05/2025.
//

import Foundation

/// Generic manager for handling favorite items.
///
/// Provides methods to toggle favorites and check if an item is marked as favorite.
class FavoritesManager<T: Codable & Identifiable & Equatable>: ObservableObject {
    /// The list of favorite items.
    @Published private(set) var items: [T] = []
    
    /// The key used to identify and init the storage
    private let storageKey: String
    
    /// Verifies if cloud is avialbel on device
    private let cloudAvailable: Bool
    
    /// Checks if should use cloud storage
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
    
    /// Toggles the favorite status of an item.
    ///
    /// - Parameter item: The item to toggle.
    func toggle(_ item: T) {
        if isFavorite(item) {
            items.removeAll { $0.id == item.id }
        } else {
            items.append(item)
        }
        save()
    }
    
    
    /// Checks if the item is marked as favorite.
    ///
    /// - Parameter item: The item to check.
    /// - Returns: `true` if the item is a favorite, otherwise `false`.
    func isFavorite(_ item: T) -> Bool {
        items.contains { $0.id == item.id }
    }
    
    /// Saves favorites to local or cloud storage.
    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        
        if useCloud {
            NSUbiquitousKeyValueStore.default.set(data, forKey: storageKey)
            NSUbiquitousKeyValueStore.default.synchronize()
        } else {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    /// Loads favorites from local or cloud storage.
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
