//
//  DriverDashboardViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

class DriverDashboardViewModel: ObservableObject {
    @Published var availableRides: [Ride] = []
    @Published var activeRides: [Ride] = []
    @Published var isOnline: Bool = false
    
    private let mockService = MockDataService.shared
    
    func loadRides(for driverId: UUID) {
        activeRides = mockService.rides.filter { $0.driverId == driverId && ($0.status == .accepted || $0.status == .inProgress) }
        availableRides = mockService.rides.filter { $0.status == .requested && $0.driverId == nil }
    }
    
    func toggleOnlineStatus() {
        isOnline.toggle()
    }
    
    func acceptRide(_ ride: Ride) {
        if let index = mockService.rides.firstIndex(where: { $0.id == ride.id }) {
            mockService.rides[index].driverId = UUID() // In real app, use current driver ID
            mockService.rides[index].status = .accepted
            loadRides(for: UUID()) // In real app, use current driver ID
        }
    }
}

