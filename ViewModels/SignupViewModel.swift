//
//  SignupViewModel.swift
//  UDrive
//
//  Created on 2024
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedUserType: UserType = .student
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func signup(completion: @escaping (User?) -> Void) {
        isLoading = true
        errorMessage = nil
        
        // Validation
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            isLoading = false
            completion(nil)
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            isLoading = false
            completion(nil)
            return
        }
        
        // Mock signup - in real app, this would call an API
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoading = false
            let user = User(
                name: self?.name ?? "",
                email: self?.email ?? "",
                userType: self?.selectedUserType ?? .student,
                phoneNumber: self?.phoneNumber.isEmpty == false ? self?.phoneNumber : nil
            )
            completion(user)
        }
    }
}

