//
//  MockDataService.swift
//  UDrive
//
//  Created on 2024
//

import Foundation
import CoreLocation

class MockDataService: ObservableObject {
    static let shared = MockDataService()
    
    @Published var users: [User] = []
    @Published var rides: [Ride] = []
    @Published var vehicles: [Vehicle] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        // Mock Users
        users = [
            User(name: "John Student", email: "john@student.edu", userType: .student, phoneNumber: "555-0101"),
            User(name: "Sarah Driver", email: "sarah@driver.com", userType: .driver, phoneNumber: "555-0202")
        ]
        
        // Mock Vehicles
        vehicles = [
            Vehicle(make: "Toyota", model: "Camry", year: 2022, color: "Blue", licensePlate: "ABC-1234", capacity: 4),
            Vehicle(make: "Honda", model: "Accord", year: 2021, color: "Red", licensePlate: "XYZ-5678", capacity: 5)
        ]
        
        // Mock Rides
        rides = [
            Ride(
                studentId: users[0].id,
                driverId: users[1].id,
                pickupLocation: Location(latitude: 37.7749, longitude: -122.4194, address: "123 Main St"),
                dropoffLocation: Location(latitude: 37.7849, longitude: -122.4094, address: "456 Oak Ave"),
                status: .inProgress,
                isEmergency: false
            )
        ]
    }
    
    func createRide(pickup: Location, dropoff: Location, isEmergency: Bool = false) -> Ride {
        let ride = Ride(
            studentId: UUID(), // In real app, use current user ID
            pickupLocation: pickup,
            dropoffLocation: dropoff,
            status: .requested,
            isEmergency: isEmergency
        )
        rides.append(ride)
        return ride
    }
    
    func getActiveRides(for userId: UUID) -> [Ride] {
        return rides.filter { ride in
            (ride.studentId == userId || ride.driverId == userId) &&
            (ride.status == .requested || ride.status == .accepted || ride.status == .inProgress)
        }
    }
}

