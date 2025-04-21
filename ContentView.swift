//
//  ContentView.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/6/25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var navPath = NavigationPath()
    @State private var numPlayers: Int = 0
    @State private var players: [Player] = []
    @State private var numQuestions: Int = 0
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.8), Color.pink.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    VStack {
                        Image(systemName: "gamecontroller.circle.fill")
                            .font(.system(size: 100))
                            .symbolEffect(.bounce, value: isAnimating)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.white, .green],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        Text("   Canon's Crazy COMP SCI Trivia!")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    NavigationLink(value: "playerSetup") {
                        HStack(spacing: 15) {
                            Text("Get Started")
                                .font(.title2.weight(.semibold))
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 18)
                        .padding(.horizontal, 40)
                        .background(
                            Capsule()
                                .fill(Color.blue.gradient)
                                .shadow(color: .blue.opacity(0.6), radius: 15, x: 0, y: 5)
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.8), lineWidth: 5)
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    Spacer()
                    
                    Text("SHOW ME WHAT YOU GOT!")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
            }
            .navigationDestination(for: String.self) { value in
                if value == "playerSetup" {
                    PlayerView(numPlayers: $numPlayers, players: $players, numQuestions: $numQuestions, navPath: $navPath)
                } else if value == "questionView" {
                    QuestionView(
                        numPlayers: $numPlayers,
                        players: $players,
                        numQuestions: $numQuestions,
                        navPath: $navPath
                    )
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                isAnimating.toggle()
            }
        }
        .tint(.blue)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
//struct ContentView: View {
//    @State private var navPath = NavigationPath()
//    @State private var numPlayers: Int = 0
//    @State private var players: [Player] = []
//    @State private var numQuestions: Int = 0
//    
//    var body: some View {
//        NavigationStack(path: $navPath) {
//            VStack {
//                Spacer()
//                Text("Trivia Off!")
//                    .font(.largeTitle)
//                    .bold()
//                
//                Spacer()
//                NavigationLink(value: "playerSetup") {
//                    Text("Get Started")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                Spacer()
//            }
//            .padding()
//            .navigationDestination(for: String.self) { value in
//                if value == "playerSetup" {
//                    PlayerView(numPlayers: $numPlayers, players: $players, numQuestions: $numQuestions, navPath: $navPath)
//                } else if value == "questionView" {
//                    QuestionView(
//                        numPlayers: $numPlayers,
//                        players: $players,
//                        numQuestions: $numQuestions
//                    )
//                }
//            }
//        }
//    }
//}
//    
//#Preview {
//        ContentView()
//    }

