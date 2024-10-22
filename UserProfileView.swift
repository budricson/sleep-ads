//
//  UserProfileView.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import SwiftUI
import Foundation

struct UserProfileView: View {
    @ObservedObject var appState: AppState
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            Text("Email: \(email)")
            
            Divider()
            
            RewardInfoView(rewardSystem: appState.rewardSystem)
        }
        .navigationTitle("User Profile")
        .onAppear {
            // Fetch user data from API or database
            username = "John Doe"
            email = "johndoe@example.com"
        }
    }
}

struct RewardInfoView: View {
    let rewardSystem: RewardSystem
    
    var body: some View {
        VStack {
            Text("Current Tier: \(rewardSystem.currentTier.rawValue)")
                .font(.headline)
            
            Text("Total Points: \(rewardSystem.currentPoints)")
                .font(.subheadline)
            
            ProgressView(value: Float(rewardSystem.currentPoints % 100), total: 100)
                .padding()
            
            Text("Next Tier: \(nextTier().rawValue)")
                .font(.caption)
        }
    }
    
    private func nextTier() -> RewardTier {
        let currentIndex = RewardTier.allCases.firstIndex(of: rewardSystem.currentTier) ?? 0
        let nextIndex = min(currentIndex + 1, RewardTier.allCases.count - 1)
        return RewardTier.allCases[nextIndex]
    }
}
