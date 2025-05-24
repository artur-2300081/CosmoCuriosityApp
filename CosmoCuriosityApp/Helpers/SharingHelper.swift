//
//  SharingHelper.swift
//  CosmoCuriosityApp
//
//  Created by Artur Drohobytskyy on 19/05/2025.
//

import UIKit

/// A utility for presenting a native share sheet using a given URL.
/// - Note: Designed to work across the app for sharing APODs, Mars photos, EPIC images, etc.
class SharingHelper {
    /// Presents a system share sheet for the given URL.
    /// - Parameter url: The URL to be shared.
    static func share(url: URL?) {
        guard let url = url else { return }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}
