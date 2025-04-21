//
//  PlayerView.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/15/25.
//

import SwiftUI
import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String = ""
    var score: Int = 0
    var onQuestion: Int = 0
    var image: String = "person.crop.circle.fill"
    var color: Color = .blue
    var showingSheet: Bool = false
    var isDone: Bool = false
}
struct PlayerView: View {
    @Binding var numPlayers: Int
    @Binding var players: [Player]
    @Binding var numQuestions: Int
    @Binding var navPath: NavigationPath
    @State private var selectedPlayerIndex: Int?
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("WHO'S PLAYING?")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Let players: [Players]")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Player Management
                HStack(spacing: 15) {
                    Button(action: addPlayer) {
                        Label("Add Player", systemImage: "plus.circle.fill")
                    }
                    .buttonStyle(GradientButtonStyle(color: .blue))
                    
                    Button(action: addQuestion) {
                        Label("Add Question", systemImage: "plus")
                    }
                    .buttonStyle(GradientButtonStyle(color: .purple))
                }
                .padding(.horizontal)
                
                // Questions Counter
                HStack {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.purple)
                    Text("Questions: \(numQuestions)")
                        .font(.headline)
                }
                .padding(8)
                .background(Capsule().fill(Color.purple.opacity(0.2)))
                
                // Players List
                List {
                    ForEach($players) { $player in
                        PlayerRow(player: $player)
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(.white.opacity(0.2))
                    }
                    .onDelete(perform: deletePlayers)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                
                // Play Button
                Button(action: startGame) {
                    HStack {
                        Text("PLAY NOW")
                        Image(systemName: "play.fill")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(GradientButtonStyle(color: .green))
                .disabled(players.isEmpty || numQuestions == 0)
                .opacity(players.isEmpty || numQuestions == 0 ? 0.6 : 1)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Player Setup")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
                .foregroundColor(.blue)
        }
    }
    
    // MARK: - Actions (unchanged functionality)
    private func addPlayer() {
        withAnimation {
            players.append(Player(name: "", score: 0))
            numPlayers += 1
        }
    }
    
    private func addQuestion() {
        withAnimation {
            numQuestions += 1
        }
    }
    
    private func startGame() {
        guard !players.isEmpty, numQuestions > 0 else { return }
        navPath.append("questionView")
    }
    
    private func deletePlayers(at offsets: IndexSet) {
        withAnimation {
            players.remove(atOffsets: offsets)
            numPlayers = players.count
        }
    }
}

// MARK: - Subviews
private struct PlayerRow: View {
    @Binding var player: Player
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Icon
            Image(systemName: player.image)
                .font(.title2)
                .foregroundColor(player.color)
                .padding(8)
                .background(Circle().fill(player.color.opacity(0.2)))
            
            // Name Field
            TextField("Player name", text: $player.name)
                .textFieldStyle(.plain)
                .font(.headline)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBackground).opacity(0.7))
                )
            
            // Color Picker Button
            Button {
                player.showingSheet.toggle()
            } label: {
                Image(systemName: "paintpalette.fill")
                    .foregroundColor(player.color)
            }
            .buttonStyle(.borderless)
            .sheet(isPresented: $player.showingSheet) {
                SheetView(player: $player)
            }
        }
        .padding(.vertical, 8)
    }
}

private struct GradientButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(color.gradient)
                    .shadow(color: color.opacity(0.3), radius: configuration.isPressed ? 2 : 4, x: 0, y: configuration.isPressed ? 1 : 2)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlayerView(
                numPlayers: .constant(2),
                players: .constant([
                    Player(name: "Jeff", color: .blue),
                    Player(name: "Jodi", color: .purple)
                ]),
                numQuestions: .constant(5),
                navPath: .constant(NavigationPath())
            )
        }
    }
}
//struct PlayerView: View {
//    @Binding var numPlayers: Int
//    @Binding var players: [Player]
//    @Binding  var numQuestions: Int
//    @State private var selectedPlayerIndex: Int?
//    
//    // For navigation
//    @Environment(\.dismiss) private var dismiss
//    @Binding var navPath: NavigationPath
//    
//    var body: some View {
//        VStack {
//            Text("WHO'S PLAYING?")
//                .font(.largeTitle)
//            
//            Button("Add Player") {
//                players.append(Player(name: "", score: 0))
//                numPlayers += 1
//            }
//            .buttonStyle(.borderedProminent)
//            
//            Text("Number of Questions: \(numQuestions)")
//            
//            Button("Add Question") {
//                numQuestions += 1
//            }
//            .buttonStyle(.bordered)
//            
//            List {
//                ForEach($players) { $player in
//                    HStack {
//                        TextField("Player Name", text: $player.name)
//                            .textFieldStyle(.roundedBorder)
//                        
//                        Spacer()
//                        
//                        Button {
//                            player.showingSheet.toggle()
//                        } label: {
//                            Text("Color:")
//                            Image(systemName: player.image)
//                        }
//                        .sheet(isPresented: $player.showingSheet) {
//                            SheetView(player: $player)
//                        }
//                    }
//                    .foregroundColor(player.color)
//                }
//            }
//            
//            Button("PLAY") {
//                // Validate at least 1 player and 1 question
//                guard !players.isEmpty, numQuestions > 0 else { return }
//                
//                // Navigate to QuestionView
//                navPath.append("questionView")
//            }
//            .buttonStyle(.borderedProminent)
//            .disabled(players.isEmpty || numQuestions == 0)
//        }
//        .padding()
//        .navigationTitle("Player Setup")
//        //.navigationBarTitleDisplayMode(.inline)
//    }
//}

// Preview with required bindings
//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView(
//            numPlayers: .constant(2),
//            players: .constant([Player(name: "Test")]),
//            numQuestions: .constant(5),
//            navPath: .constant(NavigationPath())
//        )
//    }
//}
//struct PlayerView: View{
//    @Binding var numPlayers: Int
//    @Binding var players: [Player]
//    @State private var selectedPlayerIndex: Int?
//    @State var numQuestions: Int = 0
//    var body: some View{
//        NavigationStack{
//            VStack{
//                Text("WHO'S PLAYING?")
//                    .font(.largeTitle)
//                Button("Add Player:"){
//                    players.append(Player(name: "", score: 0))
//                    numPlayers += 1
//                }
//                Text("numQuestions: \(numQuestions)")
//                Button("HOW MANY QUESTIONS?"){
//                    numQuestions += 1
//                }
//                List {
//                    ForEach( $players ){ $player in
//                        HStack {
//                            TextField("Player Name", text: $player.name)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                            Spacer()
//                            Button{
//                                player.showingSheet.toggle()
//                            }label:{
//                                Text("Color:")
//                                Image(systemName: "\($player.wrappedValue.image)")
//                            }
//                            .sheet(isPresented: $player.showingSheet) {
//                                SheetView(player: $player)
//                            }
//                        }
//                        .foregroundColor($player.wrappedValue.color)
//                    }
//                }
//                NavigationLink(destination: QuestionView(numPlayers: $numPlayers, players: $players, numQuestions: $numQuestions)){
//                    Text("PLAY")
//                }
//            }
//        }
//    }
//}
