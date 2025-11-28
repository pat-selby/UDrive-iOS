//
//  UDriveApp.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

@main
struct UDriveApp: App {
    @StateObject private var navigationService = NavigationService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationService)
        }
    }
}

