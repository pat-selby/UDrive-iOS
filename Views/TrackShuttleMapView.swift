//
//  TrackShuttleMapView.swift
//  UDrive
//
//  Created on 2024
//

import SwiftUI
import MapKit

struct TrackShuttleMapView: View {
    @StateObject private var viewModel = TrackShuttleViewModel()
    @EnvironmentObject var navigationService: NavigationService
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.region, annotationItems: annotations) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                        annotation.view
                    }
                }
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    if let ride = viewModel.ride {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Ride Status")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(ride.status.rawValue.capitalized)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                if ride.isEmergency {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                }
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.green)
                                    Text(ride.pickupLocation.address)
                                        .font(.subheadline)
                                }
                                
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                    Text(ride.dropoffLocation.address)
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(radius: 10)
                        .padding()
                    }
                }
            }
            .navigationTitle("Track Ride")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        navigationService.navigate(to: navigationService.currentUser?.userType == .student ? .studentDashboard : .driverDashboard)
                    }
                }
            }
            .onAppear {
                // Load a mock ride for demo
                let mockRide = Ride(
                    studentId: UUID(),
                    driverId: UUID(),
                    pickupLocation: Location(latitude: 37.7749, longitude: -122.4194, address: "123 Main St"),
                    dropoffLocation: Location(latitude: 37.7849, longitude: -122.4094, address: "456 Oak Ave"),
                    status: .inProgress
                )
                viewModel.loadRide(mockRide)
            }
        }
    }
    
    private var annotations: [MapAnnotation] {
        var annotations: [MapAnnotation] = []
        
        if let ride = viewModel.ride {
            // Pickup location
            annotations.append(MapAnnotation(
                coordinate: ride.pickupLocation.coordinate,
                view: AnyView(
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.green)
                            .font(.title)
                        Text("Pickup")
                            .font(.caption)
                            .padding(4)
                            .background(Color.white)
                            .cornerRadius(4)
                    }
                )
            ))
            
            // Dropoff location
            annotations.append(MapAnnotation(
                coordinate: ride.dropoffLocation.coordinate,
                view: AnyView(
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                        Text("Dropoff")
                            .font(.caption)
                            .padding(4)
                            .background(Color.white)
                            .cornerRadius(4)
                    }
                )
            ))
            
            // Driver location
            if let driverLocation = viewModel.driverLocation {
                annotations.append(MapAnnotation(
                    coordinate: driverLocation,
                    view: AnyView(
                        Image(systemName: "car.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    )
                ))
            }
        }
        
        return annotations
    }
}

struct MapAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let view: AnyView
}

