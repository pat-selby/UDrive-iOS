//
//  DriverRegistrationViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation
import SwiftUI
import UIKit

class DriverRegistrationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var licenseNumber: String = ""
    @Published var vehicleMake: String = ""
    @Published var vehicleModel: String = ""
    @Published var vehicleYear: String = ""
    @Published var vehicleColor: String = ""
    @Published var licensePlate: String = ""
    @Published var vehicleCapacity: String = "4"
    @Published var driverPhoto: UIImage?
    @Published var vehiclePhoto: UIImage?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func registerDriver(completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = nil
        
        // Validation
        guard !name.isEmpty, !email.isEmpty, !phoneNumber.isEmpty,
              !licenseNumber.isEmpty, !vehicleMake.isEmpty, !vehicleModel.isEmpty,
              !vehicleYear.isEmpty, !vehicleColor.isEmpty, !licensePlate.isEmpty else {
            errorMessage = "Please fill in all required fields"
            isLoading = false
            completion(false)
            return
        }
        
        guard driverPhoto != nil, vehiclePhoto != nil else {
            errorMessage = "Please upload both driver and vehicle photos"
            isLoading = false
            completion(false)
            return
        }
        
        // Mock registration
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.isLoading = false
            completion(true)
        }
    }
}

