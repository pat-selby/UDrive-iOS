//
//  NavigationService.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

enum AppScreen {
    case onboarding
    case login
    case signupChoice
    case studentDashboard
    case driverDashboard
    case bookRide
    case trackShuttle
    case driverRegistration
    case emergencyRide
}

class NavigationService: ObservableObject {
    @Published var currentScreen: AppScreen = .onboarding
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    func navigate(to screen: AppScreen) {
        currentScreen = screen
    }
    
    func login(user: User) {
        currentUser = user
        isLoggedIn = true
        currentScreen = user.userType == .student ? .studentDashboard : .driverDashboard
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        currentScreen = .onboarding
    }
}

