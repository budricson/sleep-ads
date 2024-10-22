//
//  LoginView.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var appState: AppState
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Login") {
                // Implement login logic here
                appState.login()
            }
            .padding()
        }
    }
}
