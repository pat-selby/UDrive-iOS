//
//  OnboardingViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    let pages = [
        OnboardingPage(
            title: "Welcome to UDrive",
            description: "Safe and reliable transportation for students",
            imageName: "car.fill"
        ),
        OnboardingPage(
            title: "Book Rides Easily",
            description: "Request a ride with just a few taps",
            imageName: "map.fill"
        ),
        OnboardingPage(
            title: "Track in Real-Time",
            description: "See your driver's location and estimated arrival",
            imageName: "location.fill"
        )
    ]
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
        }
    }
    
    func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

