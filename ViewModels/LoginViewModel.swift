//
//  LoginViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func login(completion: @escaping (User?) -> Void) {
        isLoading = true
        errorMessage = nil
        
        // Mock login - in real app, this would call an API
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
            
            // Simple mock: if email contains "student", return student user
            // If email contains "driver", return driver user
            if self?.email.lowercased().contains("student") == true {
                let user = User(name: "John Student", email: self?.email ?? "", userType: .student)
                completion(user)
            } else if self?.email.lowercased().contains("driver") == true {
                let user = User(name: "Sarah Driver", email: self?.email ?? "", userType: .driver)
                completion(user)
            } else {
                self?.errorMessage = "Invalid credentials. Try 'student@test.com' or 'driver@test.com'"
                completion(nil)
            }
        }
    }
}

