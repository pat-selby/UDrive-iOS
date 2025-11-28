//
//  Vehicle.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

struct Vehicle: Identifiable, Codable {
    let id: UUID
    var make: String
    var model: String
    var year: Int
    var color: String
    var licensePlate: String
    var capacity: Int
    var vehicleImageURL: String?
    
    init(id: UUID = UUID(), make: String, model: String, year: Int, color: String, licensePlate: String, capacity: Int, vehicleImageURL: String? = nil) {
        self.id = id
        self.make = make
        self.model = model
        self.year = year
        self.color = color
        self.licensePlate = licensePlate
        self.capacity = capacity
        self.vehicleImageURL = vehicleImageURL
    }
}

