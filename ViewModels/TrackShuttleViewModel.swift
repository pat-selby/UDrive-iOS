//
//  TrackShuttleViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation
import MapKit
import CoreLocation

class TrackShuttleViewModel: ObservableObject {
    @Published var ride: Ride?
    @Published var driverLocation: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion
    
    init() {
        // Default region (San Francisco)
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    func loadRide(_ ride: Ride) {
        self.ride = ride
        updateRegion()
        simulateDriverMovement()
    }
    
    private func updateRegion() {
        guard let ride = ride else { return }
        
        let centerLat = (ride.pickupLocation.latitude + ride.dropoffLocation.latitude) / 2
        let centerLon = (ride.pickupLocation.longitude + ride.dropoffLocation.longitude) / 2
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        
        // Simulate driver starting at pickup location
        driverLocation = ride.pickupLocation.coordinate
    }
    
    private func simulateDriverMovement() {
        guard let ride = ride else { return }
        
        // Simulate driver moving from pickup to dropoff
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
            guard let self = self, let currentLocation = self.driverLocation else {
                timer.invalidate()
                return
            }
            
            let dropoff = ride.dropoffLocation.coordinate
            let latDiff = dropoff.latitude - currentLocation.latitude
            let lonDiff = dropoff.longitude - currentLocation.longitude
            
            // Move 10% closer each update
            let newLat = currentLocation.latitude + (latDiff * 0.1)
            let newLon = currentLocation.longitude + (lonDiff * 0.1)
            
            self.driverLocation = CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
            
            // Stop when close enough
            if abs(latDiff) < 0.001 && abs(lonDiff) < 0.001 {
                timer.invalidate()
            }
        }
    }
}

