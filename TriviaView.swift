//
//  TriviaView.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/15/25.
//

import SwiftUI
import Foundation
//Player 1 Turn
//Question
//A, B, C, D Buttons
//If correct, Player 1 score++
struct TriviaView: View {
    @Binding var player: Player
    @Binding var data: Welcome
    @Binding var numQuestions: Int
    @State private var correctAnswer: String = ""
    @State private var answers: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            if player.onQuestion == numQuestions {
                Text("Round Complete!")
                    .onAppear {
                        player.isDone = true
                    }
            }
            
            if !player.isDone {
                if data.results.indices.contains(player.onQuestion) {
                    // Question Card
                    Text(data.results[player.onQuestion].question)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // Answer Buttons
                    ForEach(answers, id: \.self) { answer in
                        Button {
                            if answer == correctAnswer {
                                player.score += 100
                                print("Correct! Score: \(player.score)")
                            } else {
                                print("Incorrect!")
                            }
                            player.onQuestion += 1
                        } label: {
                            Text(answer)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    Text("Waiting for questions...")
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear {
            updateAnswers()
        }
        .onChange(of: player.onQuestion) {
            updateAnswers()
        }
    }
    
    func updateAnswers() {
        if data.results.indices.contains(player.onQuestion) {
            answers = (data.results[player.onQuestion].incorrectAnswers +
                      [data.results[player.onQuestion].correctAnswer]).shuffled()
            correctAnswer = data.results[player.onQuestion].correctAnswer
        } else {
            answers = []
        }
    }
}
//struct TriviaView: View {
//    //Take in player[numQuestion], numQuestion
//    @Binding var player: Player
//    //@Binding var numQuestion: Int
//    @Binding var data: Welcome
//    @State var correctAnswer: String = ""
//    @State var answers: [String] = []
//    var body: some View {
//        Text("Hello, World!")
//        VStack{
//            if player.onQuestion == 5 {
//                isDoneView().onAppear{
//                    player.isDone = true
//                }
//            }
//            if !player.isDone{
//                if data.results.indices.contains(player.onQuestion) {
//                    Text("\(data.results[player.onQuestion].question)")
//                    ForEach(answers, id: \.self) { answer in
//                        Button {
//                            if (answer == correctAnswer) {
//                                print("Correct!")
//                                player.score += 100
//                            } else {
//                                print("Incorrect!")
//                            }
//                            player.onQuestion += 1
//                        }label: {
//                            Text("\(answer)")
//                        }
//                        .padding()
//                    }
//                } else {
//                    //View --> "Waiting on game to finish"
//                    Text("Waiting on game to finish")
//                }
//            }
//        }
//        .onAppear {
//            updateAnswers()
//        }
//        .onChange(of: player.onQuestion) {
//            updateAnswers()
//        }
//    }
//    func updateAnswers() {
//        if data.results.indices.contains(player.onQuestion) {
//            answers = (data.results[player.onQuestion].incorrectAnswers + [data.results[player.onQuestion].correctAnswer]).shuffled()
//            correctAnswer = data.results[player.onQuestion].correctAnswer
//        } else {
//            answers = []
//        }
//    }
//}

