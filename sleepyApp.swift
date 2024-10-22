//
//  sleepyApp.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import SwiftUI

@main
struct SleepyVaultApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState)
        }
    }
}



import Foundation

struct Content: Identifiable {
    let id = UUID()
    let title: String
}

class AppState: ObservableObject {
    @Published var isLoggedIn = false
    @Published var selectedContent: Content? = nil
    @Published var rewardSystem = RewardSystem()
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
        selectedContent = nil
    }
}
