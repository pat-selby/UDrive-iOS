//
//  BookRideViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation
import CoreLocation

class BookRideViewModel: ObservableObject {
    @Published var pickupLocation: Location?
    @Published var dropoffLocation: Location?
    @Published var pickupAddress: String = ""
    @Published var dropoffAddress: String = ""
    @Published var isEmergency: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let mockService = MockDataService.shared
    
    func setPickupLocation(_ location: Location) {
        pickupLocation = location
        pickupAddress = location.address
    }
    
    func setDropoffLocation(_ location: Location) {
        dropoffLocation = location
        dropoffAddress = location.address
    }
    
    func bookRide(completion: @escaping (Ride?) -> Void) {
        guard let pickup = pickupLocation, let dropoff = dropoffLocation else {
            errorMessage = "Please select both pickup and dropoff locations"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Mock booking
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
            let ride = self?.mockService.createRide(pickup: pickup, dropoff: dropoff, isEmergency: self?.isEmergency ?? false)
            completion(ride)
        }
    }
}

