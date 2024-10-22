// RewardSystem.swift

import Foundation

enum RewardTier: String, CaseIterable {
    case bronze = "Bronze"
    case silver = "Silver"
    case gold = "Gold"
    case platinum = "Platinum"
}

struct Reward: Identifiable {
    let id = UUID()
    let points: Int
    let tier: RewardTier
    let description: String
}

class RewardSystem: ObservableObject {
    @Published var currentPoints: Int = 0
    @Published var currentTier: RewardTier = .bronze
    
    func addPoints(_ points: Int) {
        currentPoints += points
        updateTier()
    }
    
    private func updateTier() {
        switch currentPoints {
        case 0..<1000:
            currentTier = .bronze
        case 100..<5000:
            currentTier = .silver
        case 500..<10000:
            currentTier = .gold
        default:
            currentTier = .platinum
        }
    }
    
    func getReward(for quizScore: Int, sessionDuration: TimeInterval) -> Reward {
        let basePoints = quizScore * 10
        let durationBonus = Int(sessionDuration / 60) * 5  // 5 points per minute
        let totalPoints = basePoints + durationBonus
        
        addPoints(totalPoints)
        
        return Reward(points: totalPoints, tier: currentTier, description: "Completed sleep session and quiz")
    }
}
