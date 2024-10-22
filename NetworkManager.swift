//
//  NetworkManager.swift
//  sleepy
//
//  Created by Dominykas on 25/08/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchContents(completion: @escaping (Result<[Content], Error>) -> Void) {
        // Implement API call to fetch contents
        // For now, let's just return dummy data
        let dummyContents = [
            Content(title: "Arts and Entertainment"),
            Content(title: "Automotive and Transportation"),
            Content(title: "Education and Learning"),
            Content(title: "Energy and Utilities"),
            Content(title: "Environmental and Conservation"),
            Content(title: "Financial Services and Banking"),
            Content(title: "Food and Beverage"),
            Content(title: "Government and Politics"),
            Content(title: "Healthcare and Medical"),
            Content(title: "Home and Garden"),
            Content(title: "Media and Publishing"),
            Content(title: "Non-Profit and Charity"),
            Content(title: "Real Estate and Property"),
            Content(title: "Sports and Fitness"),
            Content(title: "Telecommunications and Internet"),
            Content(title: "Travel and Leisure")
        
        ]
        completion(.success(dummyContents))
    }
}
