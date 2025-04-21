//
//  VictoryView.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/19/25.
//
import SwiftUI

struct VictoryView: View {
    @Binding var players: [Player]
    @Binding var navPath: NavigationPath
    @Binding var numQuestions: Int
    @State private var winner: Player = Player(name: "", score: 0)
    
    var body: some View {
        VStack(spacing: 30) {
            // Winner announcement
            VStack(spacing: 15) {
                Text("Winner!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.yellow)
                
                Text(winner.name)
                    .font(.title)
                    .bold()
                
                Text("Score: \(winner.score)")
                    .font(.title2)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.2))
            )
            
            // All players' scores
            List {
                Section(header: Text("All Scores").font(.headline)) {
                    ForEach(players.sorted { $0.score > $1.score }, id: \.id) { player in
                        HStack {
                            Image(systemName: player.image)
                                .foregroundColor(player.color)
                            Text(player.name)
                            Spacer()
                            Text("\(player.score)")
                                .bold()
                        }
                    }
                }
            }
            .listStyle(.plain)
            Button{
                players.removeAll()
                numQuestions = 0
                navPath.removeLast(navPath.count)
            } label: {
                Text("Play Again")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Game Over")
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: findWinner)
    }
    func findWinner() {
        for player in players {
            if player.score > winner.score {
                winner.name = player.name
                winner.score = player.score
            }
        }
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VictoryView(
                players: .constant([
                    Player(name: "Rio", score: 150, color: .blue),
                    Player(name: "Roby", score: 120, color: .green),
                    Player(name: "Mazie", score: 90, color: .orange)
                ]),
                navPath: .constant(NavigationPath()),
                numQuestions: .constant(0)
            )
        }
    }
}
//import SwiftUI
//import Foundation
//
//struct VictoryView: View{
//    @Binding var players: [Player]
//    @State var winner: Player = Player(name: "", score: 0)
//    var body: some View{
//        Text("Winner is \(winner.name) with a score of \(winner.score)")
//        .onAppear(perform: findWinner)
//        Button("Play Again?"){
//            clearPlayers()
//        }
//    }
//    func findWinner() {
//        for player in players {
//            if player.score > winner.score {
//                winner.name = player.name
//                winner.score = player.score
//            }
//        }
//    }
//    func clearPlayers() {
//        players.removeAll()
//    }
//}
