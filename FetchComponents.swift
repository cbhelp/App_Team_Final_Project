//
//  FetchComponents.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/15/25.
//
import SwiftUI
import Foundation

func fetchQuestions(_ amount: Int) async throws -> Welcome {
    let url = "https://opentdb.com/api.php"
    
    guard var components = URLComponents(string: url) else {fatalError("")}
    
    components.queryItems = [
        URLQueryItem(name: "amount", value: "\(amount)"), URLQueryItem(name: "category", value: "18"), URLQueryItem(name: "type", value: "multiple")
    ]
    guard let url = components.url else { fatalError("Invalid URL") }
    
    let decoder = JSONDecoder()
    let (data, _) = try await URLSession.shared.data(from: url)
    let fakeData = try decoder.decode(Welcome.self, from: data)
    
    return fakeData
}

