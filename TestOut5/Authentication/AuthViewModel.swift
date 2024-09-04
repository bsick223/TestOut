//
//  AuthViewModel.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
// AuthViewModel.swift

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    @Published var isLoading = false
    @Published var isPasswordVisible = false
    @Published var userExists = false
    
    let authService = AuthService()
    
    func authenticate(appState: AppState) {
        isLoading = true
        Task {
            do {
                if isPasswordVisible {
                    let result = try await authService.login(email: emailText, password: passwordText, userExists: userExists)
                    
                    // Ensure the user state update happens on the main thread
                    await MainActor.run {
                        
                        appState.currentUser = result.user  // Update current user in AppState
                    }
                    
                } else {
                    userExists = try await authService.checkUserExists(email: emailText)
                    
                    // Update UI on the main thread
                    await MainActor.run {
                        isPasswordVisible = true
                    }
                }
                
                // Stop loading indicator on the main thread
                await MainActor.run {
                    isLoading = false
                }
                
            } catch {
                print("Error during authentication: \(error)")
                
                // Handle error and stop loading on the main thread
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}


