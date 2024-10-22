//
//  ContentView.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        if appState.isLoggedIn {
            ContentSelectionView(appState: appState)
        } else {
            LoginView(appState: appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState()) // Pass an instance of AppState here
    }
}
