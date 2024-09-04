//
//  AppState.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
//

// AppState.swift

import Foundation
import FirebaseAuth
import SwiftUI
import Firebase

class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoading: Bool = true  // To show loading state

    var isLoggedin: Bool {
        return currentUser != nil
    }

    init() {
        checkIfUserIsLoggedIn()
    }

    // Check Firebase for the current authenticated user
    func checkIfUserIsLoggedIn() {
            Task {
                await MainActor.run {
                    // Ensure Firebase is fully initialized before accessing Auth
                    if FirebaseApp.app() != nil {
                        if let currentUser = Auth.auth().currentUser {
                            self.currentUser = currentUser
                        }
                        self.isLoading = false // Update the loading state once the check is complete
                    } else {
                        print("Firebase not initialized yet.")
                    }
                }
            }
        }
    }
