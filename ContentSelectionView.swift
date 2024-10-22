//
//  ContentSelectionView.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import SwiftUI

struct ContentSelectionView: View {
    @ObservedObject var appState: AppState
    @State private var contents: [Content] = []
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            contentList
                .tabItem {
                    Label("Content", systemImage: "list.bullet")
                }
                .tag(0)
            
            UserProfileView(appState: appState)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(1)
            
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar")
                }
                .tag(2)
            
            SleepTrackingView(content: appState.selectedContent, appState: appState)
                .tabItem {
                    Label("Sleep", systemImage: "moon")
                }
                .tag(3)
        }
        .onAppear {
            fetchContents()
        }
    }
    
    var contentList: some View {
        List(contents, id: \.id) { content in
            Button(action: {
                appState.selectedContent = content
                selectedTab = 3 // Switch to SleepTrackingView
            }) {
                Text(content.title)
            }
        }
        .navigationTitle("Select Content")
    }
    
    func fetchContents() {
        NetworkManager.shared.fetchContents { result in
            switch result {
            case .success(let contents):
                self.contents = contents
            case .failure(let error):
                print("Error fetching contents: \(error)")
            }
        }
    }
}
