//
//  TestOut5App.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
//
// TestOut5App.swift
import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TestOut5App: App {
    
    @ObservedObject var appState = AppState()  // Keep AppState initialization here
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // Initialize Firebase in the app's entry point
//    init() {
//        if FirebaseApp.app() == nil {  // Safeguard against double initialization
//            FirebaseApp.configure()
//            print("Firebase configured successfully.")
//        } else {
//            print("Firebase already configured.")
//        }
//    }

    
    var body: some Scene {
        WindowGroup {
//            if appState.isLoggedin {
//                NavigationStack(path: $appState.navigationPath) {
//                    ChatListView()
//                        .environmentObject(appState)
//                }
//                } else {
//                AuthView()
//                    .environmentObject(appState)
//            }
            
            if appState.isLoading {
                // Show a loading view while checking authentication status
                ProgressView("Checking Authentication...")
            } else if appState.isLoggedin {
                ChatView()  // Main view for logged-in users
            } else {
                AuthView()  // Show the login/create account view
                    .environmentObject(appState)
            }
//            ChatListView()
        }
    }
}
