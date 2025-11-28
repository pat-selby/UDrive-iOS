//
//  ContentView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        Group {
            switch navigationService.currentScreen {
            case .onboarding:
                OnboardingView()
            case .login:
                LoginView()
            case .signupChoice:
                SignupChoiceView()
            case .studentDashboard:
                StudentDashboardView()
            case .driverDashboard:
                DriverDashboardView()
            case .bookRide:
                BookRideView()
            case .trackShuttle:
                TrackShuttleMapView()
            case .driverRegistration:
                DriverRegistrationView()
            case .emergencyRide:
                EmergencyRideRequestView()
            }
        }
    }
}

