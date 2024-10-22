//
//  AnalyticsView.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//
import SwiftUI
import Foundation

struct AnalyticsView: View {
    @State private var averageSleepDuration: String = ""
    @State private var sleepQuality: String = ""
    
    var body: some View {
        VStack {
            Text("Average Sleep Duration: \(averageSleepDuration)")
            Text("Sleep Quality: \(sleepQuality)")
        }
        .onAppear {
            // Fetch analytics data from API or database
            averageSleepDuration = "8 hours"
            sleepQuality = "Good"
        }
    }
}

