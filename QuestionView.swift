//
//  QuestionView.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/15/25.
//
import SwiftUI
import Foundation

struct QuestionView: View {
    @Binding var numPlayers: Int
    @Binding var players: [Player]
    @State var data: Welcome = Welcome(responseCode: 1, results: [])
    @Binding var numQuestions: Int
    @Binding var navPath: NavigationPath
    
    var body: some View {
        let allPlayersDone = players.allSatisfy { $0.isDone }
        
        Group {
            if !allPlayersDone {
                VStack(spacing: 20) {
                    // Score Header
                    Text("SCORE")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                    
                    // Players Horizontal Scroll
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach($players) { $player in
                                VStack(spacing: 8) {
                                    Image(systemName: player.image)
                                        .font(.title)
                                        .foregroundColor(player.color)
                                    Text("\(player.score)")
                                        .font(.headline)
                                    Text(player.name)
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .opacity(player.isDone ? 0.6 : 1.0)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Questions Area
                    ScrollView {
                        VStack(spacing: 30) {
                            ForEach($players) { $player in
                                if !player.isDone {
                                    VStack(spacing: 15) {
                                        Text("Question \(player.onQuestion + 1): \(player.name)'s Turn")
                                            .font(.title2)
                                            .bold()
                                        
                                        if !data.results.isEmpty {
                                            TriviaView(player: $player, data: $data, numQuestions: $numQuestions)
                                        } else {
                                            ProgressView("Loading Questions...")
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            } else {
                VictoryView(players: $players, navPath: $navPath, numQuestions: $numQuestions)
            }
        }
        .onAppear {
            Task {
                do {
                    data = try await fetchQuestions(numPlayers * numQuestions)
                } catch {
                    print(error)
                }
            }
        }
    }
}
//struct QuestionView: View{
//    @Binding var numPlayers: Int
//    @Binding var players: [Player]
//    @State var data: Welcome = Welcome(responseCode: 1, results: [])
//    @Binding var numQuestions: Int
//    var body: some View{
//        let allPlayersDone = players.allSatisfy { $0.isDone }
//        Group{
//            if !allPlayersDone{
//                VStack{
//                    Text("SCORE")
//                    HStack{
//                        ForEach($players) { $player in
//                            VStack{
//                                //Profile Image
//                                Image(systemName: "\($player.wrappedValue.image)")
//                                Text("\($player.wrappedValue.score)")
//                                Text("\($player.wrappedValue.name)")
//                            }
//                        }
//                    }
//                    ScrollView{
//                        VStack{
//                            ForEach($players){ $player in
//                                Text("Question \(player.onQuestion):")
//                                    .font(.largeTitle)
//                                    .bold()
//                                if !data.results.isEmpty {
//                                    TriviaView(player: $player, data: $data)
//                                } else {
//                                    Text("Loading Questions...")
//                                }
//                            }
//                        }
//                    }
//                }
//            } else {
//                VictoryView(players: $players)
//            }
//        }
//        .onAppear{
//            Task{
//                do{
//                    data = try await fetchQuestions(numPlayers*numQuestions)
//                }catch{
//                    print(error)
//                }
//            }
//        }
//    }
//}
