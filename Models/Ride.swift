//
//  Ride.swift
//  UDrive
//
//  Created on 2024
//

import Foundation
import CoreLocation

enum RideStatus: String, Codable {
    case requested
    case accepted
    case inProgress
    case completed
    case cancelled
    case emergency
}

struct Ride: Identifiable, Codable {
    let id: UUID
    var studentId: UUID
    var driverId: UUID?
    var pickupLocation: Location
    var dropoffLocation: Location
    var status: RideStatus
    var requestedAt: Date
    var estimatedArrival: Date?
    var isEmergency: Bool
    
    init(id: UUID = UUID(), studentId: UUID, driverId: UUID? = nil, pickupLocation: Location, dropoffLocation: Location, status: RideStatus = .requested, requestedAt: Date = Date(), estimatedArrival: Date? = nil, isEmergency: Bool = false) {
        self.id = id
        self.studentId = studentId
        self.driverId = driverId
        self.pickupLocation = pickupLocation
        self.dropoffLocation = dropoffLocation
        self.status = status
        self.requestedAt = requestedAt
        self.estimatedArrival = estimatedArrival
        self.isEmergency = isEmergency
    }
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
    var address: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double, address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
}

