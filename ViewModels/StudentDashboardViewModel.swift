//
//  StudentDashboardViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

class StudentDashboardViewModel: ObservableObject {
    @Published var activeRides: [Ride] = []
    @Published var recentRides: [Ride] = []
    
    private let mockService = MockDataService.shared
    
    func loadRides(for userId: UUID) {
        activeRides = mockService.getActiveRides(for: userId)
        recentRides = mockService.rides.filter { $0.studentId == userId && $0.status == .completed }
            .sorted { $0.requestedAt > $1.requestedAt }
            .prefix(5)
            .map { $0 }
    }
}

